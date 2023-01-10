import 'package:flutter/material.dart';
import 'package:legend_design_core/widgets/shadow/inner_box_shadow.dart';
import 'dart:math' as math;

enum ShadowSide {
  top,
  left,
  right,
}

class InnerBoxDecoration extends BoxDecoration {
  final ShadowSide shadowSide;
  final bool combine;

  const InnerBoxDecoration({
    required this.shadowSide,
    required this.combine,
    super.backgroundBlendMode,
    super.border,
    super.borderRadius,
    super.boxShadow,
    super.color,
    super.gradient,
    super.image,
    super.shape,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    assert(onChanged != null || image == null);
    return _InnerBoxDecorationPainter(this, onChanged);
  }
}

class _InnerBoxDecorationPainter extends BoxPainter {
  _InnerBoxDecorationPainter(
    this._decoration,
    VoidCallback? onChanged,
  ) : super(onChanged);

  final InnerBoxDecoration _decoration;

  Paint? _cachedBackgroundPaint;
  Rect? _rectForCachedBackgroundPaint;
  Paint _getBackgroundPaint(Rect rect, TextDirection? textDirection) {
    assert(
        _decoration.gradient != null || _rectForCachedBackgroundPaint == null);

    if (_cachedBackgroundPaint == null ||
        (_decoration.gradient != null &&
            _rectForCachedBackgroundPaint != rect)) {
      final Paint paint = Paint();
      if (_decoration.backgroundBlendMode != null) {
        paint.blendMode = _decoration.backgroundBlendMode!;
      }
      if (_decoration.color != null) {
        paint.color = _decoration.color!;
      }
      if (_decoration.gradient != null) {
        paint.shader = _decoration.gradient!
            .createShader(rect, textDirection: textDirection);
        _rectForCachedBackgroundPaint = rect;
      }
      _cachedBackgroundPaint = paint;
    }

    return _cachedBackgroundPaint!;
  }

  void _paintBox(
      Canvas canvas, Rect rect, Paint paint, TextDirection? textDirection) {
    switch (_decoration.shape) {
      case BoxShape.circle:
        assert(_decoration.borderRadius == null);
        final Offset center = rect.center;
        final double radius = rect.shortestSide / 2.0;
        canvas.drawCircle(center, radius, paint);
        break;
      case BoxShape.rectangle:
        if (_decoration.borderRadius == null) {
          canvas.drawRect(rect, paint);
        } else {
          canvas.drawRRect(
              _decoration.borderRadius!.resolve(textDirection).toRRect(rect),
              paint);
        }
        break;
    }
  }

  void _paintShadows(Canvas canvas, Rect rect, TextDirection? textDirection) {
    if (_decoration.boxShadow == null) {
      return;
    }
    for (final BoxShadow boxShadow in _decoration.boxShadow!) {
      if (boxShadow is InnerBoxShadow) {
        continue;
      }
      final Paint paint = boxShadow.toPaint();
      final Rect bounds =
          rect.shift(boxShadow.offset).inflate(boxShadow.spreadRadius);
      _paintBox(canvas, bounds, paint, textDirection);
    }
  }

  void _paintBackgroundColor(
      Canvas canvas, Rect rect, TextDirection? textDirection) {
    if (_decoration.color != null || _decoration.gradient != null) {
      _paintBox(canvas, rect, _getBackgroundPaint(rect, textDirection),
          textDirection);
    }
  }

  DecorationImagePainter? _imagePainter;
  void _paintBackgroundImage(
      Canvas canvas, Rect rect, ImageConfiguration configuration) {
    if (_decoration.image == null) {
      return;
    }
    _imagePainter ??= _decoration.image!.createPainter(onChanged!);
    Path? clipPath;
    switch (_decoration.shape) {
      case BoxShape.circle:
        assert(_decoration.borderRadius == null);
        final Offset center = rect.center;
        final double radius = rect.shortestSide / 2.0;
        final Rect square = Rect.fromCircle(center: center, radius: radius);
        clipPath = Path()..addOval(square);
        break;
      case BoxShape.rectangle:
        if (_decoration.borderRadius != null) {
          clipPath = Path()
            ..addRRect(_decoration.borderRadius!
                .resolve(configuration.textDirection)
                .toRRect(rect));
        }
        break;
    }
    _imagePainter!.paint(canvas, rect, clipPath, configuration);
  }

  @override
  void dispose() {
    _imagePainter?.dispose();
    super.dispose();
  }

  /// Paint the box decoration into the given location on the given canvas.
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection? textDirection = configuration.textDirection;
    _paintShadows(canvas, rect, textDirection);
    _paintBackgroundColor(canvas, rect, textDirection);
    _paintBackgroundImage(canvas, rect, configuration);
    _paintInnerShadows(canvas, rect, textDirection);
    _decoration.border?.paint(
      canvas,
      rect,
      shape: _decoration.shape,
      borderRadius: _decoration.borderRadius?.resolve(textDirection),
      textDirection: configuration.textDirection,
    );
  }

  @override
  String toString() {
    return 'BoxPainter for $_decoration';
  }

  void _paintInnerShadows(
    Canvas canvas,
    Rect rect,
    TextDirection? textDirection,
  ) {
    if (_decoration.boxShadow == null) {
      return;
    }
    for (final BoxShadow boxShadow in _decoration.boxShadow!) {
      if (boxShadow is! InnerBoxShadow) {
        continue;
      }

      final color = boxShadow.color;

      final borderRadiusGeometry = _decoration.borderRadius ??
          (_decoration.shape == BoxShape.circle
              ? BorderRadius.circular(rect.longestSide)
              : BorderRadius.zero);
      final borderRadius = borderRadiusGeometry.resolve(textDirection);

      final clipRRect = borderRadius.toRRect(rect);

      final innerRect = deflate(
        rect,
        boxShadow.spreadRadius,
        boxShadow.blurRadius,
        _decoration.shadowSide,
        _decoration.combine,
      );
      if (innerRect.isEmpty) {
        final paint = Paint()..color = color;
        canvas.drawRRect(clipRRect, paint);
      }

      var innerRRect = borderRadius.toRRect(innerRect);

      canvas.save();
      canvas.clipRRect(clipRRect);

      final outerRect = _areaCastingShadowInHole(
        rect,
        boxShadow,
        _decoration,
      );

      canvas.drawDRRect(
        RRect.fromRectAndRadius(outerRect, Radius.zero),
        innerRRect.shift(boxShadow.offset),
        Paint()
          ..color = color
          ..colorFilter = ColorFilter.mode(color, BlendMode.srcIn)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, boxShadow.blurSigma),
      );
      canvas.restore();
    }
  }
}

Rect _areaCastingShadowInHole(
  Rect holeRect,
  BoxShadow shadow,
  InnerBoxDecoration _decoration,
) {
  var bounds = holeRect;
  bounds = inflate(
    bounds,
    shadow.blurRadius,
    shadow.blurRadius,
    _decoration.shadowSide,
    _decoration.combine,
  );

  if (shadow.spreadRadius < 0) {
    bounds = bounds.inflate(-shadow.spreadRadius);
  }

  final offsetBounds = bounds.shift(shadow.offset);

  return _unionRects(bounds, offsetBounds);
}

/// Returns a new rectangle with edges moved outwards by the given delta.
Rect inflate(
  Rect rect,
  double delta,
  double blurRadius,
  ShadowSide shadowSide,
  bool combine,
) {
  switch (shadowSide) {
    case ShadowSide.left:
      return Rect.fromLTRB(
        rect.left - delta,
        rect.top - (combine ? 0 : blurRadius),
        rect.right,
        rect.bottom + blurRadius,
      );
    case ShadowSide.top:
      return Rect.fromLTRB(
        rect.left - blurRadius,
        rect.top - delta,
        rect.right + blurRadius,
        rect.bottom,
      );
    case ShadowSide.right:
      return Rect.fromLTRB(
        rect.left,
        rect.top - (combine ? 0 : blurRadius),
        rect.right + delta,
        rect.bottom + blurRadius,
      );
  }
}

Rect deflate(
  Rect rect,
  double delta,
  double blurRadius,
  ShadowSide shadowSide,
  bool combine,
) {
  return inflate(rect, -delta, blurRadius, shadowSide, combine);
}

Rect _unionRects(Rect a, Rect b) {
  if (a.isEmpty) {
    return b;
  }

  if (b.isEmpty) {
    return a;
  }

  final left = math.min(a.left, b.left);
  final top = math.min(a.top, b.top);
  final right = math.max(a.right, b.right);
  final bottom = math.max(a.bottom, b.bottom);

  return Rect.fromLTRB(left, top, right, bottom);
}

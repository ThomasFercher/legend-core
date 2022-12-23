import 'package:flutter/widgets.dart';

const Color _shadowColor = Color.fromARGB(64, 0, 0, 0);

///
/// A Box whic
///
class ElevatedBox extends StatelessWidget {
  final double elevation;
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  late final Color shadowColor;
  late final BoxDecoration _decoration;
  late final LegendBoxShadow shadow = LegendBoxShadow(
    elevation: elevation,
    blurStyle: BlurStyle.solid,
    color: shadowColor,
  );

  ElevatedBox({
    super.key,
    required this.elevation,
    required this.child,
    Color? shadowColor,
    this.margin = const EdgeInsets.all(4),
    this.padding = EdgeInsets.zero,
    BoxDecoration? decoration,
  }) {
    this.shadowColor = shadowColor ?? _shadowColor;

    assert(elevation >= 0.0, 'Elevation has to a positive number!');
    if (elevation > 0) {
      _decoration = decoration?.copyWith(
            boxShadow: [shadow],
          ) ??
          BoxDecoration(
            boxShadow: [shadow],
          );
    } else {
      _decoration = decoration ?? BoxDecoration();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: DecoratedBox(
        decoration: _decoration,
        child: Padding(
          padding: padding,
          child: ClipRRect(
            child: child,
            borderRadius: _decoration.borderRadius?.resolve(
                  TextDirection.ltr,
                ) ??
                BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}

class LegendBoxShadow extends BoxShadow {
  final double elevation;

  LegendBoxShadow({
    required this.elevation,
    super.blurStyle,
    super.offset,
    super.color,
  }) : super(
          blurRadius: elevation * 2,
          spreadRadius: 0.0,
        );
}

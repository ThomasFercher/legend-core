import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LegendDetector extends StatelessWidget {
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final void Function(bool)? onHover;
  final void Function(PointerHoverEvent event)? onHoverEvent;
  final void Function()? onTap;
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final Color background;

  final bool disableVisualFeedback;

  const LegendDetector({
    super.key,
    required this.child,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTap,
    this.borderRadius,
    this.onHoverEvent,
    this.disableVisualFeedback = false,
    Color? background,
  }) : background = background ?? Colors.transparent;

  @override
  Widget build(BuildContext context) {
    if (disableVisualFeedback) {
      return _noFeedBack(context);
    }

    final _highlightColor =
        background == Colors.transparent ? Colors.white24 : Colors.transparent;

    return Material(
      color: background,
      borderRadius: borderRadius,
      child: MouseRegion(
        opaque: true,
        onEnter: (e) {
          if (onEnter != null) onEnter!(e);
          if (onHover != null) onHover!(true);
        },
        onExit: (e) {
          if (onExit != null) onExit!(e);
          if (onHover != null) onHover!(false);
        },
        cursor: SystemMouseCursors.click,
        onHover: onHoverEvent,
        child: InkWell(
          borderRadius: borderRadius?.resolve(
            Directionality.of(context),
          ),
          hoverColor: Colors.transparent,
          splashColor: Colors.white10,
          focusColor: Colors.transparent,
          highlightColor: _highlightColor,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }

  Widget _noFeedBack(BuildContext context) {
    return MouseRegion(
      opaque: true,
      onEnter: (e) {
        if (onEnter != null) onEnter!(e);
        if (onHover != null) onHover!(true);
      },
      onExit: (e) {
        if (onExit != null) onExit!(e);
        if (onHover != null) onHover!(false);
      },
      cursor: SystemMouseCursors.click,
      onHover: onHoverEvent,
      child: GestureDetector(
        onTap: onTap,
        child: child,
      ),
    );
  }
}

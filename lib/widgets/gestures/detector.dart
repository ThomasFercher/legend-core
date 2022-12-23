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
  final double elevation;
  final Color? shadowColor;

  final Duration animationDuration;

  const LegendDetector({
    super.key,
    required this.child,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTap,
    this.borderRadius,
    this.shadowColor,
    this.onHoverEvent,
    this.elevation = 0,
    this.animationDuration = const Duration(milliseconds: 200),
    Color? background,
  }) : background = background ?? Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      elevation: elevation,
      animationDuration: animationDuration,
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
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}

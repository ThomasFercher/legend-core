import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:legend_utils/extensions/extensions.dart';

class LegendDetector extends StatefulWidget {
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final void Function(bool)? onHover;
  final void Function(PointerHoverEvent event)? onHoverEvent;
  final void Function()? onTap;

  final Widget child;
  final EdgeInsets padding;
  final BorderRadiusGeometry? borderRadius;

  final Color background;
  late final Color activeBackground;

  LegendDetector({
    Key? key,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTap,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
    this.background = Colors.transparent,
    this.onHoverEvent,
    Color? activeBackground,
  }) : super(key: key) {
    this.activeBackground = activeBackground ?? background.darken(0.1);
  }

  @override
  State<LegendDetector> createState() => _LegendDetectorState();
}

class _LegendDetectorState extends State<LegendDetector> {
  late bool isHovered;
  late Color _background;

  @override
  void initState() {
    isHovered = false;
    _background = widget.background;
    super.initState();
  }

  void onHover() {
    if (widget.onHover != null) widget.onHover!(isHovered);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: true,
      onEnter: (e) {
        if (isHovered == false) {
          setState(() {
            isHovered = true;
            _background = widget.activeBackground;
          });
          if (widget.onEnter != null) widget.onEnter!(e);
          onHover();
        }
      },
      onExit: (e) {
        if (isHovered == true) {
          setState(() {
            isHovered = false;
            _background = widget.background;
          });
          if (widget.onExit != null) widget.onExit!(e);
          onHover();
        }
      },
      onHover: widget.onHoverEvent,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: widget.child,
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            color: _background,
          ),
        ),
      ),
    );
  }
}

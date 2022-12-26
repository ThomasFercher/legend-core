import 'package:flutter/material.dart';

import '../gestures/detector.dart';

// This widget displays an animated icon that changes color based on whether it is selected or hovered over.
// The widget uses an AnimationController to animate the color of the icon between enabled and disabled states.
// The widget also has a LegendDetector child widget that captures tap and hover events and triggers the appropriate actions.
// When the icon is tapped, the onPressed callback function is called. When the icon is hovered over, the AnimationController is triggered.
// The widget uses a Container to apply padding and a box shadow effect around the icon.
// The box shadow effect is based on the current color of the icon, which is determined by the AnimationController.
// The widget also has an optional iconSize parameter that can be used to specify the size of the icon.

class LegendAnimatedIcon extends StatefulWidget {
  final IconData icon;
  final LegendAnimtedIconTheme theme;
  final void Function() onPressed;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final bool isSelected;
  final bool disableShadow;

  const LegendAnimatedIcon({
    required this.icon,
    required this.theme,
    required this.onPressed,
    this.isSelected = false,
    this.iconSize,
    this.padding = const EdgeInsets.all(4),
    this.disableShadow = false,
  });

  @override
  _LegendAnimatedIconState createState() => _LegendAnimatedIconState();
}

class _LegendAnimatedIconState extends State<LegendAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late bool hovered;
  late AnimationController _controller;
  late Animation<Color?> _animation;
  late Color? color;

  @override
  void initState() {
    hovered = false;
    color = widget.theme.disabled;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    _animation =
        ColorTween(begin: widget.theme.disabled, end: widget.theme.enabled)
            .animate(_controller)
          ..addListener(
            () {
              setState(() {
                color = _animation.value;
              });
            },
          );
    if (widget.isSelected) _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LegendDetector(
      background: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      onTap: () => widget.onPressed(),
      onHover: (value) {
        if (value && !hovered && !widget.isSelected) {
          if (!_controller.isAnimating || !hovered) {
            _controller.forward();
            hovered = true;
          }
        } else if (!widget.isSelected) {
          if (!_controller.isAnimating || hovered) {
            _controller.reverse();
            hovered = false;
          }
        }
      },
      child: Container(
        padding: widget.padding,
        decoration: widget.disableShadow
            ? null
            : BoxDecoration(
                boxShadow: [
                  widget.theme.getAnimatedShadow(color),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.iconSize ?? 8 / 2),
                ),
              ),
        child: Icon(
          widget.icon,
          color: color,
          size: widget.iconSize,
        ),
      ),
    );
  }
}

class LegendAnimtedIconTheme {
  final Color enabled;
  final Color disabled;
  late BoxShadow enabledBoxShadow;

  LegendAnimtedIconTheme({
    required this.enabled,
    required this.disabled,
    BoxShadow? boxShadow,
  }) {
    enabledBoxShadow = boxShadow ??
        BoxShadow(
          color: enabled.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 16,
          offset: Offset(0, 0),
        );
  }

  BoxShadow getAnimatedShadow(Color? color) {
    return BoxShadow(
      color: color?.withOpacity(0.2) ?? Colors.transparent,
      blurRadius: enabledBoxShadow.blurRadius,
      offset: enabledBoxShadow.offset,
      spreadRadius: enabledBoxShadow.spreadRadius,
    );
  }
}

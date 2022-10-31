import 'package:flutter/material.dart';

class RippleDetector extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final void Function(bool)? onHover;
  final BorderRadius? borderRadius;
  final Color? highlightColor;

  const RippleDetector({
    Key? key,
    required this.child,
    this.onHover,
    this.onTap,
    this.borderRadius,
    this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: borderRadius,
        child: child,
        onTap: onTap,
        onHover: onHover,
        highlightColor: highlightColor,
      ),
    );
  }
}

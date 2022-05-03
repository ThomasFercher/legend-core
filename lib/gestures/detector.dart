import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:legend_design_core/utils/extensions.dart';

class LegendDetector extends StatefulWidget {
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final void Function(bool)? onHover;
  final void Function()? onTap;
  final Widget child;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  const LegendDetector({
    Key? key,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTap,
    required this.child,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<LegendDetector> createState() => _LegendDetectorState();
}

class _LegendDetectorState extends State<LegendDetector> {
  late bool isHovered;

  @override
  void initState() {
    isHovered = false;
    super.initState();
  }

  void onHover() {
    if (widget.onHover != null) widget.onHover!(isHovered);

    print(isHovered);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: true,
      onEnter: (e) {
        if (isHovered == false) {
          setState(() {
            isHovered = true;
          });
          widget.onEnter.executeIf(widget.onEnter != null);
          onHover();
        }
      },
      onExit: (e) {
        if (isHovered == true) {
          setState(() {
            isHovered = false;
          });
          widget.onExit.executeIf(widget.onExit != null);
          onHover();
        }
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          child: widget.child,
          padding: widget.padding ?? EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
          ),
        ),
      ),
    );
  }
}

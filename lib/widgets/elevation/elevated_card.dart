import 'package:flutter/widgets.dart';
import 'package:legend_design_core/widgets/elevation/elevation_box.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';

class ElevatedCard extends StatelessWidget {
  ElevatedCard({
    super.key,
    required this.elevation,
    required this.child,
    this.background,
    this.borderRadius,
    this.padding = EdgeInsets.zero,
    this.onHover,
    this.onTap,
    this.width,
    this.height,
    this.border,
  });

  final double elevation;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Color? background;
  final EdgeInsets padding;
  final Widget child;
  final void Function(bool hovered)? onHover;
  final void Function()? onTap;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return LegendDetector(
      onTap: onTap,
      onEnter: (e) {
        if (onHover != null) onHover!(true);
      },
      onExit: (e) {
        if (onHover != null) onHover!(false);
      },
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: border,
            color: background,
          ),
          padding: padding,
          elevation: elevation,
          child: child,
        ),
      ),
    );
  }
}

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
  });

  final double elevation;
  final BorderRadius? borderRadius;
  final Color? background;
  final EdgeInsets padding;
  final Widget child;
  final void Function(bool hovered)? onHover;
  final void Function()? onTap;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: background,
      ),
      padding: padding,
      elevation: elevation,
      child: LegendDetector(
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
          child: child,
        ),
      ),
    );
  }
}

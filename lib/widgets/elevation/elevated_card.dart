import 'package:flutter/widgets.dart';
import 'package:legend_design_core/widgets/elevation/elevation_box.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({
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
    this.disableVisualFeedback = true,
    this.margin = EdgeInsets.zero,
  });

  final double elevation;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Color? background;
  final EdgeInsets padding;
  final Widget child;
  final void Function(bool hovered)? onHover;
  final void Function()? onTap;
  final bool disableVisualFeedback;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: SizedBox(
        width: width,
        height: height,
        child: LegendDetector(
          onTap: onTap,
          onEnter: (e) {
            if (onHover != null) onHover!(true);
          },
          onExit: (e) {
            if (onHover != null) onHover!(false);
          },
          background: background,
          borderRadius: borderRadius,
          disableVisualFeedback: disableVisualFeedback,
          child: ElevatedBox(
            elevation: elevation,
            child: child,
            margin: EdgeInsets.zero,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: border,
              color: disableVisualFeedback ? background : null,
            ),
          ),
        ),
      ),
    );
  }
}

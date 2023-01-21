import 'package:flutter/widgets.dart';
import 'package:legend_design_core/widgets/elevation/elevation_box.dart';
import 'package:legend_design_core/state/legend_state.dart';

class LegendSection extends LegendWidget {
  final Widget child;
  final Color? color;
  final Widget? title;
  final double elevation;
  final double? spacing;
  final AlignmentGeometry titleAligment;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  const LegendSection({
    Key? key,
    required this.child,
    this.title,
    this.color,
    this.elevation = 0,
    this.spacing,
    this.titleAligment = Alignment.centerLeft,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return ElevatedBox(
      margin: EdgeInsets.zero,
      elevation: elevation,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      padding: padding ?? EdgeInsets.zero,
      child: title != null
          ? Column(
              children: [
                Align(alignment: titleAligment, child: title!),
                SizedBox(
                  height: spacing ?? theme.sizing.spacing2,
                ),
                child,
              ],
            )
          : child,
    );
  }
}

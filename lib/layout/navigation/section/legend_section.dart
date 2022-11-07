import 'package:flutter/widgets.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevation_box.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:legend_design_core/state/legend_state.dart';

class LegendSection extends LegendWidget {
  final Widget child;
  final Color? color;
  final String? title;
  final double elevation;
  final double? spacing;

  const LegendSection({
    Key? key,
    required this.child,
    this.title,
    this.color,
    this.elevation = 0,
    this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return ElevatedBox(
      elevation: elevation,
      decoration: BoxDecoration(
        color: color ?? theme.colors.background2,
        borderRadius: theme.sizing.radius2.asRadius(),
      ),
      padding: EdgeInsets.all(
        theme.sizing.spacing2,
      ),
      child: title != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendText(
                  title,
                  textStyle: theme.typography.h5,
                ),
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

import 'package:flutter/widgets.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_utils/legend_utils.dart';

class LegendSection extends StatelessWidget {
  final Widget child;
  final Color? color;
  final String? title;

  const LegendSection({
    Key? key,
    required this.child,
    this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    return Container(
      decoration: BoxDecoration(
        color: color ?? theme.colors.background2,
        borderRadius: theme.sizing.radius1.asRadius(),
      ),
      padding: EdgeInsets.all(
        theme.sizing.spacing2,
      ),
      child: title != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendText(
                  text: title,
                  textStyle: theme.typography.h5,
                ),
                SizedBox(
                  height: theme.sizing.spacing1,
                ),
                child,
              ],
            )
          : child,
    );
  }
}

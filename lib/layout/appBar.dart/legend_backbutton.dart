import 'package:flutter/material.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';

class LegendBackButton extends LegendWidget {
  const LegendBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    return Padding(
      padding: EdgeInsets.only(
        right: 12,
      ),
      child: LegendAnimatedIcon(
        padding: EdgeInsets.all(4),
        icon: theme.typography.backIcon,
        iconSize: theme.sizing.iconSize4,
        disableShadow: true,
        theme: LegendAnimtedIconTheme(
          enabled: theme.colors.selection,
          disabled: theme.appBarColors.foreground,
        ),
        onPressed: () {
          LegendRouter.of(context).popPage();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:provider/provider.dart';

import '../../../styles/theming/theme_provider.dart';

class CollapsedMenu extends StatelessWidget {
  final double width;

  const CollapsedMenu({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();

    return Container(
      width: width,
      child: LegendAnimatedIcon(
        padding: EdgeInsets.all(0),
        iconSize: theme.appBarSizing.iconSize ?? 32,
        onPressed: () {
          Scaffold.of(context).openEndDrawer();
        },
        icon: Icons.menu,
        theme: LegendAnimtedIconTheme(
          disabled: theme.colors.appBarColors.foreground,
          enabled: theme.colors.selectionColor,
        ),
      ),
    );
  }
}

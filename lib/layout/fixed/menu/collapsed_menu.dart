import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/provider.dart';

class CollapsedMenu extends StatefulWidget {
  final double width;

  const CollapsedMenu({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<CollapsedMenu> createState() => _CollapsedMenuState();
}

class _CollapsedMenuState extends State<CollapsedMenu> {
  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();

    return Container(
      width: widget.width,
      alignment: Alignment.center,
      child: LegendAnimatedIcon(
        padding: EdgeInsets.all(0),
        iconSize: theme.appBarSizing.iconSize ?? 32,
        onPressed: () {
          Scaffold.of(context).openEndDrawer();
        },
        icon: Icons.menu,
        disableShadow: true,
        theme: LegendAnimtedIconTheme(
          disabled: theme.colors.appBarPalette.foreground,
          enabled: theme.colors.selection,
        ),
      ),
    );
  }
}

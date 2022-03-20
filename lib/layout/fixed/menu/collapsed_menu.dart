import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/router/router_provider.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
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
    ThemeProvider theme = context.watch<ThemeProvider>();

    return Container(
      width: widget.width,
      child: GestureDetector(
        onTap: () {
          RouterProvider.of(context).pushPage(
            settings: const RouteSettings(name: '/siderMenu'),
          );
          /*  RouterProvider.of(context).pushPage(
              settings: const RouteSettings(name: '/siderMenu'),
            );*/
          //      Scaffold.of(context).openEndDrawer();
        },
        child: LegendAnimatedIcon(
          padding: EdgeInsets.all(0),
          iconSize: theme.appBarSizing.iconSize ?? 32,
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: Icons.menu,
          disableShadow: true,
          theme: LegendAnimtedIconTheme(
            disabled: theme.colors.appBarColors.foreground,
            enabled: theme.colors.selectionColor,
          ),
        ),
      ),
    );
  }
}

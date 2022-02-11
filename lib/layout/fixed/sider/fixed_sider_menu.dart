import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/drawers/sidermenu_vertical_tile.dart';
import 'package:legend_design_core/layout/fixed/sider/fixed_sider.dart';
import 'package:legend_design_core/layout/fixed/sider/siderInfo.dart';
import 'package:legend_design_core/layout/fixed/sider/sider_submenu.dart';
import 'package:legend_design_core/objects/drawer_menu_tile.dart';
import 'package:legend_design_core/objects/menu_option.dart';
import 'package:legend_design_core/router/routeInfoProvider.dart';
import 'package:legend_design_core/router/router_provider.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:provider/src/provider.dart';

class FixedSiderMenu extends StatelessWidget {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? backgroundColorSub;
  final Color? foregroundColorSub;
  final bool isCollapsed;

  FixedSiderMenu({
    Key? key,
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundColorSub,
    this.foregroundColorSub,
    this.isCollapsed = false,
  }) : super(key: key);

  List<Widget> getTiles(BuildContext context) {
    List<Widget> tiles = [];
    List<MenuOption> options = RouterProvider.of(context).menuOptions;

    FixedSider? fixedSider = SiderInfo.of(context)?.fixedSider;
    MenuOption? sel = RouteInfoProvider.getCurrentMenuOption(context);
    ThemeProvider theme = context.watch<ThemeProvider>();

    for (final MenuOption option in options) {
      if (option.children == null || !(fixedSider?.showSubMenu ?? false)) {
        if (isCollapsed) {
          tiles.add(
            SiderMenuVerticalTile(
              icon: option.icon,
              path: option.page,
              title: option.title,
              collapsed: true,
              iconSize: 30,
              activeColor: Colors.tealAccent,
              backgroundColor: theme.colors.primaryColor,
              color: theme.colors.textColorLight,
            ),
          );
        } else {
          tiles.add(
            DrawerMenuTile(
              icon: option.icon,
              title: option.title,
              path: option.page,
              backgroundColor: backgroundColor ??
                  theme.colors.siderColorTheme.backgroundMenu,
              left: false,
              activeColor: theme.colors.selectionColor,
              color: foregroundColor ?? theme.colors.siderColorTheme.foreground,
              collapsed: false,
              forceColor: option == sel,
            ),
          );
        }
      } else if (fixedSider?.showSubMenu ?? false) {
        tiles.add(
          SiderSubMenu(
            option: option,
            backgroundColor: backgroundColorSub,
            foregroundColor: foregroundColorSub,
            collapsed: isCollapsed,
          ),
        );
      }
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();
    List<Widget> tiles = getTiles(context);

    return Container(
      color: backgroundColor ?? theme.colors.siderColorTheme.backgroundMenu,
      padding: const EdgeInsets.only(
        top: 24.0,
      ),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: tiles,
      ),
    );
  }
}

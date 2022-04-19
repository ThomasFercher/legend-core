import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:legend_design_core/layout/drawers/sidermenu_vertical_tile.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/submenu/sider_submenu.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/src/provider.dart';

class FixedSiderMenu extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color activeBackgroundColor;
  final Color activeForegroundColor;
  final Color subMenuColor;
  final bool showMenuSubItems;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final bool subMenuExpanded;

  FixedSiderMenu({
    Key? key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.activeBackgroundColor,
    required this.activeForegroundColor,
    required this.subMenuColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.showMenuSubItems = true,
    this.subMenuExpanded = true,
    this.spacing = 12,
  }) : super(key: key);

  /// This Method returns the whole menu.
  /// If a [MenuOption] has children, a [SiderSubMenu] is added, else
  /// we add a [DrawerMenuTile].
  List<Widget> getTiles(BuildContext context) {
    List<Widget> tiles = [];
    List<MenuOption> options = LegendRouter.of(context).menuOptions;

    MenuOption? sel = RouteInfoProvider.getCurrentMenuOption(context);
    LegendTheme theme = context.watch<LegendTheme>();

    for (final MenuOption option in options) {
      if (option.children == null || !(showMenuSubItems)) {
        tiles.add(
          DrawerMenuTile(
            activeBackground: activeBackgroundColor,
            icon: option.icon,
            title: option.title,
            path: option.page,
            backgroundColor: backgroundColor,
            activeColor: theme.colors.selection,
            color: foregroundColor,
            forceColor: option == sel,
            borderRadius: theme.sizing.borderRadius[0],
          ),
        );
      } else if (showMenuSubItems) {
        tiles.add(
          SiderSubMenu(
            option: option,
            backgroundColor: activeBackgroundColor,
            activeBackground: Colors.indigo[900]!,
            foregroundColor: foregroundColor,
            disabledBackground: backgroundColor,
            subMenuColor: subMenuColor,
            alwaysExpanded: subMenuExpanded,
          ),
        );
      }
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = getTiles(context);

    return Container(
      color: backgroundColor,
      padding: padding,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: tiles.traillingPaddingCol(spacing),
      ),
    );
  }
}

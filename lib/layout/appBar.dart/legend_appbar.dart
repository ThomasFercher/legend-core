import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/navigation/menu/fixed_menu.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_title.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/menu/menu_sizing.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/routes/extensions.dart';
import '../../styles/colors/subcolors/micros/menu/menu_colors.dart';
import 'appbar_layout.dart';
import 'legend_backbutton.dart';

const List<Widget> actionsFiller = [SizedBox.shrink()];

class LegendAppBar extends LegendWidget {
  final LegendAppBarConfig config;
  final ScaffoldBuilder? actions;
  final Widget? title;
  final Widget? logo;
  final bool showMenu;
  final bool showTitle;
  final bool showLogo;
  final bool showBackButton;
  final AppBarLayoutType type;

  final Widget? bottom;

  const LegendAppBar({
    required this.config,
    this.actions,
    this.logo,
    this.title,
    this.showMenu = true,
    this.showLogo = true,
    this.showTitle = true,
    this.showBackButton = true,
    required this.type,
    this.bottom,
  });

  FixedMenu getMenu(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    final menuColors = theme.colors.appBar.menuColors;
    final sizing = theme.appBarSizing.menuSizing;
    final routes = LegendRouter.of(context).topRoutes;
    switch (type) {
      case AppBarLayoutType.MeTiAc:
        return FixedMenu(
          sizing: sizing,
          showMenuSubItems: false,
          colors: menuColors,
          options: routes,
        );
      case AppBarLayoutType.TiMeAc:
        return FixedMenu(
          sizing: sizing,
          showMenuSubItems: false,
          colors: menuColors,
          options: routes,
        );
    }
  }

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: config.appBarHeight),
          decoration: BoxDecoration(
            color: theme.appBarColors.background,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: config.horizontalPadding),
            child: AppBarDelegate(
              type: type,
              children: {
                if (showBackButton) AppBarItem.backButton: LegendBackButton(),
                if (showTitle) AppBarItem.title: title ?? ScaffoldTitle(),
                if (showMenu) AppBarItem.menu: getMenu(context),
                if (actions != null)
                  AppBarItem.actions: LegendScaffoldBuilder(builder: actions!),
              },
            ),
          ),
        ),
        if (bottom != null) bottom!,
      ],
    );
  }
}

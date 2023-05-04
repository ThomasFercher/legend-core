import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/navigation/menu/collapsed_menu.dart';
import 'package:legend_design_core/layout/navigation/menu/fixed_menu.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_title.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_design_core/router/extension.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'appbar_layout.dart';
import 'legend_backbutton.dart';

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
  final BoxDecoration collapsedMenuDecoration;

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
    this.collapsedMenuDecoration = const BoxDecoration(),
  });

  Widget _menu(BuildContext context) {
    final theme = LegendTheme.of(context);
    final router = context.legendRouter;
    final menuColors = theme.colors.appBar.menuColors;
    final sizing = theme.appBarSizing.menuSizing;
    final routes = List.of(
      router.getTopRoutes<PageInfo>().where((element) => element.isMenu),
    );

    final scaffoldConfig = ScaffoldInfo.of(context).config;
    final builder = scaffoldConfig.builders.fixedMenuBuilder;
    return builder?.call(context, routes, router.current) ??
        FixedMenu(
          sizing: sizing,
          showMenuSubItems: false,
          colors: menuColors,
          options: routes,
        );
  }

  Widget _collapsedMenu(BuildContext context) {
    return ScaffoldInfo.of(context)
            .config
            .builders
            .collapsedMenuBuilder
            ?.call(context) ??
        CollapsedMenu(
          decoration: collapsedMenuDecoration,
        );
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
                if (showMenu) ...{
                  AppBarItem.menu: _menu(context),
                  AppBarItem.collapsedMenu: _collapsedMenu(context),
                },
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

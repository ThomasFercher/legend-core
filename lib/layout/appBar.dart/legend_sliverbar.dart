import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_layout.dart';
import 'package:legend_design_core/layout/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_backbutton.dart';
import 'package:legend_design_core/layout/navigation/menu/collapsed_menu.dart';
import 'package:legend_design_core/layout/navigation/menu/fixed_menu.dart';
import 'package:legend_design_core/layout/navigation/tabbar/legend_tabbar.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_title.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/router/extension.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_design_core/widgets/layout/has_height.dart';
import 'package:legend_router/legend_router.dart';

const List<Widget> actionsFiller = [
  SizedBox(
    height: 0,
    width: 0,
  )
];

class LegendSliverBar extends LegendWidget implements HasHeight {
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

  const LegendSliverBar({
    required this.config,
    this.actions,
    this.logo,
    this.title,
    this.showMenu = true,
    this.showLogo = true,
    this.showTitle = true,
    this.showBackButton = true,
    this.type = AppBarLayoutType.TiMeAc,
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

  PreferredSize _bottom(BuildContext context) {
    final route = LegendRouter.of(context).routerDelegate.current;
    final theme = LegendTheme.of(context);
    final layout = ScaffoldInfo.of(context).getLayout(theme);

    if (layout.appBarLayout.showTabbar == true && route != null) {
      var routes = [route];

      if (route.children != null && route.children!.isNotEmpty) {
        routes.addAll(route.children!);
      } else {
        final parent = RouteInfoProvider.getParentRouteInfo(context, route);
        if (parent != null) {
          routes = [parent];
          if (parent.children != null) routes.addAll(parent.children!);
        }
      }
      final height = theme.appBarSizing.tabbarSizing?.height ?? 56;
      return PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height),
          child: LegendTabBar(
            routes: routes,
          ),
        ),
      );
    }
    return PreferredSize(child: Container(), preferredSize: Size.zero);
  }

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final _showBackButton = !PlatformInfo.isWeb &&
        !LegendRouter.of(context).isFirstOnStack &&
        showBackButton;

    return SliverAppBar(
      leadingWidth: 0,
      titleSpacing: 0,
      elevation: config.elevation,
      toolbarHeight: config.appBarHeight,
      pinned: config.pinned,
      leading: Container(),
      snap: config.snap,
      floating: config.floating,
      scrolledUnderElevation: config.elevation,
      actions: actionsFiller,
      forceElevated: config.forceElevate,
      backgroundColor: theme.appBarColors.background,
      bottom: _bottom(context),
      title: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: config.appBarHeight),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: config.horizontalPadding),
          child: AppBarDelegate(
            type: type,
            children: {
              if (_showBackButton) AppBarItem.backButton: LegendBackButton(),
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
    );
  }

  @override
  double get height => config.appBarHeight;
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_layout.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_provider.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_layout.dart';
import 'package:legend_design_core/layout/bottomBar.dart/legend_bottom_bar.dart';
import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_design_core/layout/config/route_layout.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer_layout.dart';
import 'package:legend_design_core/layout/scaffold/contents/header/scaffold_header.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/widgets/decoration/inner_elevation.dart';
import 'package:legend_design_core/widgets/shadow/inner_box_decoration.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'contents/scaffold_sider.dart';
import 'package:legend_design_core/state/legend_state.dart';

class LegendScaffold extends LegendWidget {
  // Core
  final Widget child;
  final RouteInfo route;

  // Configs
  final DynamicRouteLayout dynamicLayout;
  final ScaffoldBuilders builders;
  final ScaffoldWhether whether;

  LegendScaffold({
    required this.child,
    required this.dynamicLayout,
    required this.whether,
    required this.builders,
    required this.route,
  });

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    // Bottom Bar Layout
    final layout = dynamicLayout.getLayout(theme.sizing.key);

    final w = SizeInfo.of(
      context,
    ); // TODO: Find a better way to rebuild when theme.sizing.key changes

    bool showBottomBar = layout.bottomBarLayout is! NoBottomBarLayout;

    // Update Navigation Bar Color if needed
    Color _systemNavigationBarColor = showBottomBar
        ? theme.colors.bottomBar.backgroundColor
        : theme.colors.background1;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: _systemNavigationBarColor,
      ),
    );

    final appBarLayout = layout.appBarLayout;

    bool showHeader = appBarLayout != null &&
        appBarLayout.layout == AppBarLayoutConfig.fixedAbove;
    return ScaffoldInfo(
      routeLayout: layout,
      routeInfo: route,
      showHeader: showHeader,
      scaffold: this,
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            Column(
              children: [
                if (showHeader)
                  ScaffoldHeader(
                    context: context,
                    layout: appBarLayout,
                  ),
                Expanded(
                  child: Row(
                    children: [
                      ScaffoldSider(),
                      Expanded(
                        child: child,
                      ),
                    ],
                  ),
                ),
                if (showBottomBar)
                  LegendBottomBar(
                    options: LegendRouter.of(context).topRoutes,
                  )
              ],
            ),
            if (showHeader) headerShadow(layout, theme, context),
          ],
        ),
      ),
    );
  }

  Widget headerShadow(
      RouteLayout routeLayout, LegendTheme theme, BuildContext context) {
    final siderShowing = routeLayout.siderLayout != null;
    final appBarShowing = routeLayout.appBarLayout != null &&
        routeLayout.appBarLayout!.layout == AppBarLayoutConfig.fixedAbove;
    final tabbarShowing = routeLayout.appBarLayout?.showTabbar ?? false;

    final provider = context.watch<AppBarProvider>();
    final menuDrawerShowing = routeLayout.menuDrawerLayout != null &&
        routeLayout.menuDrawerLayout!.type ==
            MenuDrawerLayoutType.beneathAppBar;

    // Shadow Positioning
    double top = 0;
    if (appBarShowing) {
      top = theme.appBarSizing.appBarHeight;
    }
    if (tabbarShowing) {
      top += theme.appBarSizing.tabbarSizing!.height;
    }

    bool show = true;
    if (menuDrawerShowing) {
      if (provider.menuShownAfterAnimation && !provider.showMenu) {
        show = false;
      }

      if (!provider.menuShownAfterAnimation && provider.showMenu) {
        show = false;
      }

      if (provider.menuShownAfterAnimation && provider.showMenu) {
        show = false;
      }
    }

    double left = 0;
    double right = 0;
    if (siderShowing) {
      left = routeLayout.siderLayout!.left ? theme.siderSizing.width : 0;
      right = routeLayout.siderLayout!.left ? 0 : theme.siderSizing.width;
    }

    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: 0,
      child: AnimatedOpacity(
        duration:
            show ? Duration(milliseconds: 200) : Duration(milliseconds: 10),
        opacity: show ? 1 : 0,
        child: IgnorePointer(
          child: InnerElevation(
            shadowSide: ShadowSide.top,
          ),
        ),
      ),
    );
  }
}

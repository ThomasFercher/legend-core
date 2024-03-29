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
import 'package:legend_design_core/layout/sider/sider_layout.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/router/extension.dart';
import 'package:legend_design_core/state/provider/legend_provider.dart';
import 'package:legend_design_core/widgets/decoration/inner_elevation.dart';
import 'package:legend_design_core/widgets/shadow/inner_box_decoration.dart';
import 'contents/scaffold_sider.dart';
import 'package:legend_design_core/state/legend_state.dart';

class LegendScaffold extends LegendWidget {
  // Core
  final Widget child;
  final RouteInfo route;

  // Configs
  final ScaffoldConfig config;

  const LegendScaffold({
    required this.child,
    required this.route,
    required this.config,
  });

  DynamicRouteLayout get routeLayout => config.layout;

  ScaffoldBuilders get builders => config.builders;

  ScaffoldWhether get whether => config.whether;

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final key = theme.sizing.key;
    final layout = routeLayout.get(key);
    final showBottomBar = layout.bottomBarLayout is! NoBottomBarLayout;
    final appBarLayout = layout.appBarLayout;
    final showHeader = appBarLayout is! NoAppBarLayout &&
        appBarLayout.layout == AppBarLayoutConfig.fixedAbove;

    // Update Navigation Bar Color if needed
    final _systemNavigationBarColor = showBottomBar
        ? theme.colors.bottomBar.backgroundColor
        : theme.colors.background1;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: _systemNavigationBarColor,
      ),
    );

    return UnfocusHandler(
      child: ScaffoldInfo(
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
                      options: context.menuRoutes,
                    )
                ],
              ),
              if (showHeader && false) headerShadow(layout, theme, context),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// TODO: Make optional and also let user define the elevation value
  ///
  Widget headerShadow(
    RouteLayout routeLayout,
    LegendTheme theme,
    BuildContext context,
  ) {
    final siderShowing = routeLayout.siderLayout is! NoSiderLayout;
    final appBarShowing = routeLayout.appBarLayout is! NoAppBarLayout &&
        routeLayout.appBarLayout.layout == AppBarLayoutConfig.fixedAbove;
    final tabbarShowing = routeLayout.appBarLayout.showTabbar;

    final provider = LegendProvider.of<AppBarProvider>(context);
    final menuDrawerShowing = routeLayout.menuDrawerLayout
            is! NoMenuDrawerLayout &&
        routeLayout.menuDrawerLayout.type == MenuDrawerLayoutType.beneathAppBar;

    // Shadow Positioning
    double top = 0;
    if (appBarShowing) {
      top = theme.appBarSizing.appBarHeight;
    }
    if (tabbarShowing) {
      top += theme.appBarSizing.tabbarSizing!.height;
    }

    bool show = true;
    if (menuDrawerShowing && provider.showMenu) {
      show = false;
    }

    double left = 0;
    double right = 0;
    if (siderShowing) {
      left = routeLayout.siderLayout.left ? theme.siderSizing.width : 0;
      right = routeLayout.siderLayout.left ? 0 : theme.siderSizing.width;
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

class UnfocusHandler extends StatelessWidget {
  final Widget child;

  const UnfocusHandler({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: child,
    );
  }
}

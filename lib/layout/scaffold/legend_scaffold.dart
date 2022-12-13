import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_layout.dart';
import 'package:legend_design_core/layout/bottomBar.dart/legend_bottom_bar.dart';
import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_design_core/layout/scaffold/contents/header/scaffold_header.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
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
    bool showBottomBar = layout.bottomBarLayout != null;

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
      scaffold: this,
      child: Material(
        type: MaterialType.transparency,
        child: Column(
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
      ),
    );
  }
}

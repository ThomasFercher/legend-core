export 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/layout/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/bottomBar.dart/legend_bottom_bar.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_header.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/sizing/size_info.dart';
import 'package:legend_router/router/route_info_provider.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../config/appbar_layout.dart';
import 'contents/scaffold_sider.dart';

class LegendScaffold extends StatelessWidget {
  // Core
  final String pageName;
  final Widget child;

  final DynamicRouteLayout layout;

  // Configs
  final ScaffoldBuilders builders;
  final ScaffoldWhether whether;
  final ScaffoldSizing sizing;

  //
  final RouteInfo route;
  final RouteDisplay? display;

  LegendScaffold({
    required this.pageName,
    required this.child,
    required this.layout,
    this.whether = const ScaffoldWhether(),
    this.builders = const ScaffoldBuilders(),
    this.sizing = const ScaffoldSizing(),
    required this.route,
    required this.display,
  });

  /// Copies the config onto to the base
  /// If one attribute is not null in config it will override the same attribute from base
  factory LegendScaffold.withConfig(
      LegendScaffold base, ScaffoldConfig config) {
    return LegendScaffold(
      display: base.display,
      route: base.route,
      layout: base.layout,
      pageName: base.pageName,
      child: base.child,
      builders: config.builders != null
          ? ScaffoldBuilders.copyWith(base.builders, config.builders!)
          : base.builders,
      sizing: config.sizing != null
          ? ScaffoldSizing.copyWith(base.sizing, config.sizing!)
          : base.sizing,
      whether: config.whether != null
          ? ScaffoldWhether.copyWith(base.whether, config.whether!)
          : base.whether,
    );
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    ScaffoldConfig? config = theme.scaffoldConfig;

    return ScaffoldInfo(
      display: display,
      routeInfo: route,
      scaffold: config != null ? LegendScaffold.withConfig(this, config) : this,
      child: SizeInfo(
        sizing: theme.sizingTheme,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Builder(builder: (context) {
          // Bottom Bar Layout
          BottomBarLayout bottomBarLayout = ScaffoldInfo.of(context)
              .scaffold
              .layout
              .getLayout(theme.sizingTheme.key)
              .bottomBarLayout;
          bool showBottomBar = bottomBarLayout == BottomBarLayout.Show;

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

          return Scaffold(
            bottomNavigationBar: LegendBottomBar(
              colors: theme.bottomBarPalette,
              sizing: theme.bottomBarSizing!,
              options: LegendRouter.of(context).routeDisplays,
            ).boolInit(showBottomBar),
            endDrawerEnableOpenDragGesture: false,
            appBar: _appBar(context, theme),
            body: ColoredBox(
              color: theme.colors.background1,
              child: Row(
                children: [
                  ScaffoldSider(),
                  Expanded(
                    child: Container(
                      child: child,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  PreferredSize? _appBar(BuildContext context, LegendTheme theme) {
    AppBarLayout l = ScaffoldInfo.of(context).getLayout(theme).appBarLayout;
    double bottomHeight = 0;
    if (route is TabviewPageInfo) {
      TabviewPageInfo routeInfo = route as TabviewPageInfo;
      bottomHeight = routeInfo.style.height;
    } else if (route is TabviewChildPageInfo) {
      RouteInfo? parent = RouteInfoProvider.getParentRouteInfo(context, route);
      TabviewPageInfo parentRouteINfo = parent as TabviewPageInfo;
      bottomHeight = parentRouteINfo.style.height;
    }
    if (l.layout == AppBarLayoutConfig.fixedAbove) {
      return PreferredSize(
        child: ScaffoldHeader(),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          theme.appBarSizing.appBarHeight + bottomHeight,
        ),
      );
    } else {
      return null;
    }
  }
}

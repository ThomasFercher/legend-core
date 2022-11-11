import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/layout/bottomBar.dart/legend_bottom_bar.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_header.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_router/router/route_info_provider.dart';
import 'package:legend_router/router/routes/extensions.dart';
import '../config/appbar_layout.dart';
import 'contents/scaffold_sider.dart';
import 'package:legend_design_core/state/legend_state.dart';

class LegendScaffold extends LegendWidget {
  // Core
  final String pageName;
  final Widget child;

  final DynamicRouteLayout layout;

  // Configs
  final ScaffoldBuilders builders;
  final ScaffoldWhether whether;

  //
  final RouteInfo route;

  LegendScaffold({
    required this.pageName,
    required this.child,
    required this.layout,
    this.whether = const ScaffoldWhether(),
    this.builders = const ScaffoldBuilders(),
    required this.route,
  });

  /// Copies the config onto to the base
  /// If one attribute is not null in config it will override the same attribute from base
  factory LegendScaffold.withConfig(
      LegendScaffold base, ScaffoldConfig config) {
    return LegendScaffold(
      route: base.route,
      layout: base.layout,
      pageName: base.pageName,
      child: base.child,
      builders: config.builders != null
          ? ScaffoldBuilders.copyWith(base.builders, config.builders!)
          : base.builders,
      whether: config.whether != null
          ? ScaffoldWhether.copyWith(base.whether, config.whether!)
          : base.whether,
    );
  }

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    ScaffoldConfig? config = theme.scaffoldConfig;

    return ScaffoldInfo(
      routeInfo: route,
      scaffold: config != null ? LegendScaffold.withConfig(this, config) : this,
      child: SizeInfo(
        context: context,
        child: Builder(builder: (context) {
          final theme = LegendTheme.of(context);

          // Bottom Bar Layout
          final bottomBarLayout = ScaffoldInfo.of(context)
              .scaffold
              .layout
              .getLayout(theme.sizing.key)
              .bottomBarLayout;
          bool showBottomBar = bottomBarLayout != null;

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
              colors: theme.bottomBarColors,
              sizing: theme.bottomBarSizing,
              options: LegendRouter.of(context)
                  .routes
                  .get<PageInfo>()
                  .where((element) => element.depth == 1)
                  .toList(),
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
    final layout = ScaffoldInfo.of(context).getLayout(theme).appBarLayout;
    double bottomHeight = 0;

    if (layout?.showTabbar ?? false) {
      bottomHeight = theme.appBarSizing.tabbarSizing?.height ?? 48;
    }

    return PreferredSize(
      child: ScaffoldHeader(),
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        theme.appBarSizing.appBarHeight + bottomHeight,
      ),
    );
  }
}

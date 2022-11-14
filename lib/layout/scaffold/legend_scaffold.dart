import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/layout/bottomBar.dart/legend_bottom_bar.dart';
import 'package:legend_design_core/layout/layout_config.dart';
import 'package:legend_design_core/layout/scaffold/contents/header/scaffold_header.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_router/router/route_info_provider.dart';
import 'package:legend_router/router/routes/extensions.dart';
import '../appBar.dart/appbar_layout_config.dart';
import 'contents/scaffold_sider.dart';
import 'package:legend_design_core/state/legend_state.dart';

class LegendScaffold extends LegendWidget {
  // Core
  final Widget child;

  final DynamicRouteLayout layout;

  // Configs
  final ScaffoldBuilders builders;
  final ScaffoldWhether whether;

  //
  final RouteInfo route;

  LegendScaffold({
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
    ScaffoldConfig config = theme.scaffoldConfig;

    return ScaffoldInfo(
      routeInfo: route,
      scaffold: LegendScaffold.withConfig(this, config),
      child: SizeInfo(
        context: context,
        child: Builder(
          builder: (context) {
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

            return Material(
              type: MaterialType.transparency,
              child: ColoredBox(
                color: theme.colors.background1,
                child: Column(
                  children: [
                    ScaffoldHeader(context: context),
                    Expanded(
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
                    if (showBottomBar)
                      LegendBottomBar(
                        colors: theme.bottomBarColors,
                        sizing: theme.bottomBarSizing,
                        options: LegendRouter.of(context).topRoutes,
                      )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

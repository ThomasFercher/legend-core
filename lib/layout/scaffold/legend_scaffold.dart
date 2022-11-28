import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legend_design_core/layout/bottomBar.dart/legend_bottom_bar.dart';
import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_design_core/layout/footer/fixed_footer.dart';
import 'package:legend_design_core/layout/scaffold/contents/header/scaffold_header.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
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
          ? ScaffoldBuilders.copyWith(config.builders!, base.builders)
          : base.builders,
      whether: config.whether != null
          ? ScaffoldWhether.copyWith(config.whether!, base.whether)
          : base.whether,
    );
  }

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final scaffoldInfo = LegendScaffold.withConfig(
      this,
      theme.scaffoldConfig,
    );
    // Bottom Bar Layout
    final layout = scaffoldInfo.layout.getLayout(theme.sizing.key);
    bool showBottomBar = layout.bottomBarLayout != null;
    bool showFooter = layout.footerLayout != null;

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
    return ScaffoldInfo(
      routeInfo: route,
      scaffold: scaffoldInfo,
      child: Material(
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
                      child: Column(
                        children: [
                          Expanded(
                            child: child,
                          ),
                          if (showFooter) ScaffoldFooter(),
                        ],
                      ),
                    )
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
      ),
    );
  }
}

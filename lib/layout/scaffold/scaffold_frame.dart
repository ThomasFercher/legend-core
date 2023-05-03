import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'legend_scaffold.dart';

class ScaffoldFrame extends LegendWidget {
  final LegendRouteInfo page;
  final Widget child;

  const ScaffoldFrame({
    Key? key,
    required this.page,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final routeConfig = page.config;
    final scaffoldConfig = theme.scaffoldConfig;

    final config = ScaffoldConfig.override(scaffoldConfig, routeConfig);

    return LegendScaffold(
      config: config,
      child: child,
      route: page,
    );
  }
}

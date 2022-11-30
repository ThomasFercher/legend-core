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
    final config = page.config;
    final builders = ScaffoldBuilders.override(
        theme.scaffoldConfig.builders, config.builders);
    final whether =
        ScaffoldWhether.override(theme.scaffoldConfig.whether, config.whether);

    return LegendScaffold(
      dynamicLayout: config.layout,
      builders: builders,
      whether: whether,
      child: child,
      route: page,
    );
  }
}

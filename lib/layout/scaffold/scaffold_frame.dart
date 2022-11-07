import 'package:flutter/material.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'legend_scaffold.dart';

class ScaffoldFrame extends StatelessWidget {
  final LegendRouteInfo page;
  final Widget child;

  const ScaffoldFrame({
    Key? key,
    required this.page,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScaffoldRouteConfig config = page.config;
    return LegendScaffold(
      layout: config.layout,
      builders: config.builders,
      whether: config.whether,
      child: child,
      pageName: "test", // ?

      route: page,
    );
  }
}

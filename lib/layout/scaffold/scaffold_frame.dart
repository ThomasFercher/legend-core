import 'package:flutter/material.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_router/router/routes/route_info.dart';
import 'legend_scaffold.dart';

class ScaffoldFrame extends StatelessWidget {
  final LegendRouteInfo page;
  final RouteDisplay? display;
  final Widget child;

  const ScaffoldFrame({
    Key? key,
    required this.page,
    required this.child,
    required this.display,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScaffoldRouteConfig config = page.config;
    return LegendScaffold(
      layout: config.layout,
      builders: config.builders,
      sizing: config.sizing,
      whether: config.whether,
      child: child,
      pageName: "test", // ?
      display: display,
      route: page,
    );
  }
}

import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_design_core/layout/scaffold/config/builders.dart';
import 'package:legend_design_core/layout/scaffold/config/whether.dart';
import 'package:legend_router/legend_router.dart';

abstract class LegendRouteInfo extends PageRouteInfo {
  final ScaffoldRouteConfig config;
  final bool isMenu;

  const LegendRouteInfo({
    required this.config,
    required super.name,
    required super.page,
    required super.title,
    this.isMenu = false,
    super.arguments,
    super.children,
    super.icon,
  });
}

class PageInfo extends LegendRouteInfo {
  const PageInfo({
    required super.config,
    required super.name,
    required super.page,
    required super.title,
    super.isMenu,
    super.arguments,
    super.children,
    super.icon,
  });
}

class ScaffoldRouteConfig {
  // Configs
  final ScaffoldBuildersOverride? builders;
  final ScaffoldWhetherOverride? whether;
  final DynamicRouteLayout layout;

  const ScaffoldRouteConfig({
    required this.layout,
    this.whether,
    this.builders,
  });
}

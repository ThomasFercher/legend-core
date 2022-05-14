import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/scaffold/config/builders.dart';
import 'package:legend_design_core/layout/scaffold/config/sizing.dart';
import 'package:legend_design_core/layout/scaffold/config/whether.dart';
import 'package:legend_router/router/legend_router.dart';

class ScaffoldRouteInfo extends RouteInfo {
  final ScaffoldRouteConfig config;

  const ScaffoldRouteInfo({
    required this.config,
    required super.name,
    required super.page,
    super.arguments,
    super.children,
  });
}

class ScaffoldRouteConfig {
  // Core
  final AppBarLayoutType appBarLayoutType;
  final String pageName;
  final List<Widget> children;

  // Configs
  final ScaffoldBuilders builders;
  final ScaffoldWhether whether;
  final ScaffoldSizing sizing;
  final DynamicRouteLayout layout;

  const ScaffoldRouteConfig({
    required this.pageName,
    required this.layout,
    this.appBarLayoutType = AppBarLayoutType.TiMeAc,
    this.children = const [],
    this.whether = const ScaffoldWhether(),
    this.builders = const ScaffoldBuilders(),
    this.sizing = const ScaffoldSizing(),
  });
}

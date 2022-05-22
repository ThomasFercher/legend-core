import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/navigation/tabbar/legend_tabbar.dart';
import 'package:legend_design_core/layout/scaffold/config/builders.dart';
import 'package:legend_design_core/layout/scaffold/config/sizing.dart';
import 'package:legend_design_core/layout/scaffold/config/whether.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/routes/route_display.dart';

abstract class LegendRouteInfo extends RouteInfo {
  final ScaffoldRouteConfig config;

  const LegendRouteInfo({
    required this.config,
    required super.name,
    required super.page,
    super.arguments,
    super.children,
  });
}

class PageInfo extends LegendRouteInfo {
  PageInfo({
    required super.config,
    required super.name,
    required super.page,
    super.children,
    super.arguments,
  });
}

class TabviewPageInfo extends LegendRouteInfo {
  final TabBarStyle style;

  TabviewPageInfo({
    required this.style,
    required super.config,
    required super.name,
    required super.children,
    super.page = const SizedBox(),
    super.arguments,
  });
}

class TabviewChildPageInfo extends LegendRouteInfo {
  TabviewChildPageInfo({
    required super.name,
    required super.page,
    super.children,
    super.arguments,
    required super.config,
  });
}

class ScaffoldRouteConfig {
  // Core
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
    this.children = const [],
    this.whether = const ScaffoldWhether(),
    this.builders = const ScaffoldBuilders(),
    this.sizing = const ScaffoldSizing(),
  });
}

class TabRouteDisplay extends RouteDisplay {
  TabRouteDisplay({
    required super.title,
    required super.route,
    required super.children,
    super.icon,
  });
}

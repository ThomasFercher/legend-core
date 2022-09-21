import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/navigation/tabbar/legend_tabbar.dart';
import 'package:legend_design_core/layout/scaffold/config/builders.dart';
import 'package:legend_design_core/layout/scaffold/config/whether.dart';
import 'package:legend_router/router/legend_router.dart';

abstract class LegendRouteInfo extends RouteInfo {
  final ScaffoldRouteConfig config;

  const LegendRouteInfo({
    required this.config,
    required super.name,
    required super.page,
    required super.title,
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
    super.arguments,
    super.children,
    super.icon,
  });
}

class TabviewPageInfo extends LegendRouteInfo {
  final TabBarStyle style;

  const TabviewPageInfo({
    required this.style,
    required super.config,
    required super.name,
    required super.children,
    required super.title,
    super.page = const SizedBox(),
    super.arguments,
    super.icon,
  });
}

class TabviewChildPageInfo extends LegendRouteInfo {
  const TabviewChildPageInfo({
    required super.name,
    required super.page,
    super.children,
    super.arguments,
    required super.config,
    required super.title,
    super.icon,
  });
}

class ScaffoldRouteConfig {
  // Core
  final String pageName;
  final List<Widget> children;

  // Configs
  final ScaffoldBuilders builders;
  final ScaffoldWhether whether;
  final DynamicRouteLayout layout;

  const ScaffoldRouteConfig({
    required this.pageName,
    required this.layout,
    this.children = const [],
    this.whether = const ScaffoldWhether(),
    this.builders = const ScaffoldBuilders(),
  });
}

import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/scaffold/config/builders.dart';
import 'package:legend_design_core/layout/scaffold/config/sizing.dart';
import 'package:legend_design_core/layout/scaffold/config/whether.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_router/router/legend_router.dart';

class ScaffoldRouteInfo extends RouteInfo {
  final ScaffoldRouteConfig config;

  const ScaffoldRouteInfo({
    required this.config,
    required String name,
    required Widget page,
    Iterable<ScaffoldRouteInfo>? children,
    Object? arguments,
    bool? isUnderlying,
  }) : super(
          name: name,
          page: page,
          children: children,
          arguments: arguments,
          isUnderyling: isUnderlying,
        );
}

class ScaffoldRouteConfig {
  // Core
  final LayoutType layoutType;
  final AppBarLayoutType appBarLayoutType;
  final String pageName;

  final List<Widget> children;

  // Configs
  final ScaffoldBuilders builders;
  final ScaffoldWhether whether;
  final ScaffoldSizing sizing;

  const ScaffoldRouteConfig({
    required this.layoutType,
    required this.pageName,
    this.appBarLayoutType = AppBarLayoutType.TiMeAc,
    this.children = const [],
    this.whether = const ScaffoldWhether(),
    this.builders = const ScaffoldBuilders(),
    this.sizing = const ScaffoldSizing(),
  });
}

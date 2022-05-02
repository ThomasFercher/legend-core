import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/scaffold/config/builders.dart';
import 'package:legend_design_core/layout/scaffold/config/sizing.dart';
import 'package:legend_design_core/layout/scaffold/config/whether.dart';

import '../../styles/layouts/layout_type.dart';

abstract class RouteInfo {
  final String name;
  final Widget child;

  final Object? arguments;
  final bool? isUnderyling;

  @mustCallSuper
  const RouteInfo({
    required this.name,
    required this.child,
    this.isUnderyling,
    this.arguments,
  });
}

class ScaffoldRouteInfo {
  // Core
  final LayoutType layoutType;
  final AppBarLayoutType appBarLayoutType;
  final String pageName;

  final List<Widget> children;

  // Configs
  final ScaffoldBuilders builders;
  final ScaffoldWhether whether;
  final ScaffoldSizing sizing;

  const ScaffoldRouteInfo({
    required this.layoutType,
    required this.pageName,
    this.appBarLayoutType = AppBarLayoutType.TiMeAc,
    this.children = const [],
    this.whether = const ScaffoldWhether(),
    this.builders = const ScaffoldBuilders(),
    this.sizing = const ScaffoldSizing(),
  });
}

class PageRouteInfo extends RouteInfo {
  final List<RouteInfo>? children;
  final ScaffoldRouteInfo info;

  const PageRouteInfo({
    required this.info,
    required String name,
    required Widget child,
    Object? arguments,
    bool? isUnderlying,
    this.children,
  }) : super(
          name: name,
          child: child,
          arguments: arguments,
          isUnderyling: isUnderlying,
        );
}

class ModalRouteInfo extends RouteInfo {
  ModalRouteInfo({
    required Widget child,
    required String name,
    Object? arguments,
    bool? isUnderlying,
  }) : super(
          name: name,
          child: child,
          arguments: arguments,
          isUnderyling: isUnderlying,
        );
}

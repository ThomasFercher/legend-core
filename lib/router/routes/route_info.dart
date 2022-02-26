import 'package:flutter/widgets.dart';
import 'package:legend_design_core/router/routes/section_info.dart';

abstract class RouteInfo {
  final String name;
  final Widget page;
  final Object? arguments;
  final bool? isUnderyling;

  @mustCallSuper
  const RouteInfo({
    required this.name,
    required this.page,
    this.isUnderyling,
    this.arguments,
  });
}

class SectionRouteInfo extends RouteInfo {
  final List<SectionInfo> sections;
  final List<RouteInfo>? children;

  SectionRouteInfo({
    required this.sections,
    required String name,
    required Widget page,
    Object? arguments,
    bool? isUnderlying,
    this.children,
  }) : super(
          name: name,
          page: page,
          arguments: arguments,
          isUnderyling: isUnderlying,
        );
}

class PageRouteInfo extends RouteInfo {
  final List<RouteInfo>? children;
  PageRouteInfo({
    required String name,
    required Widget page,
    Object? arguments,
    bool? isUnderlying,
    this.children,
  }) : super(
          name: name,
          page: page,
          arguments: arguments,
          isUnderyling: isUnderlying,
        );
}

class ModalRouteInfo extends RouteInfo {
  ModalRouteInfo({
    required Widget body,
    required String name,
    Object? arguments,
    bool? isUnderlying,
  }) : super(
          name: name,
          page: body,
          arguments: arguments,
          isUnderyling: isUnderlying,
        );
}

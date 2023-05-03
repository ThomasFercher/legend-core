import 'package:flutter/material.dart';
import 'package:legend_router/legend_router.dart';
import 'layout_delegate.dart';

abstract class RoutesDelegate {
  RouteInfo? onGenerateRoute(RouteSettings settings) => null;

  bool hideRoutes(RouteInfo c, BuildContext context) => false;

  List<RouteInfo> buildRoutes(
    LayoutInfo layouts,
  );
}

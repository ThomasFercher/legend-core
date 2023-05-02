import 'package:flutter/material.dart';
import 'package:legend_router/legend_router.dart';
import 'layout_delegate.dart';

abstract class RoutesDelegate {
  RouteInfo? onGenerateRoute(RouteSettings settings);

  bool hideRoutes(RouteInfo c, BuildContext context);

  List<RouteInfo> buildRoutes(
    LayoutInfo layouts,
  );
}

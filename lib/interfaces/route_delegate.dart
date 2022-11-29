import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_router/legend_router.dart';

abstract class RoutesDelegate {
  const RoutesDelegate();

  List<RouteInfo> buildRoutes(
    Map<String, DynamicRouteLayout> layouts,
  );
}

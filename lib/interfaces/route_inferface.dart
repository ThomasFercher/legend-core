import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_router/router/legend_router.dart';

import '../layout/scaffold/config/scaffold_config.dart';

abstract class RouteInterface<T> {
  const RouteInterface();

  Map<T, DynamicRouteLayout> buildLayouts(
    List<double> splits,
  );

  List<RouteInfo> buildRoutes(
    Map<T, DynamicRouteLayout> layouts,
  );

  ScaffoldConfig buildConfig();
}

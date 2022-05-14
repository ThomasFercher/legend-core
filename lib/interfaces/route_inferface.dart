import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/routes/route_display.dart';

abstract class RouteInterface<T> {
  const RouteInterface();

  Map<T, DynamicRouteLayout> buildLayouts(LegendTheme theme);
  List<RouteInfo> buildRoutes(
      Map<T, DynamicRouteLayout> layouts, LegendTheme theme);
  List<SimpleRouteDisplay> buildDisplays();
}

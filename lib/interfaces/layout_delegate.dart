import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';

typedef LayoutInfo = Map<Enum, DynamicRouteLayout>;

abstract class LayoutDelegate {
  ScaffoldConfig buildConfig(Map<Enum, DynamicRouteLayout> routeLayouts);

  LayoutInfo buildLayouts(
    List<double> splits,
  );
}

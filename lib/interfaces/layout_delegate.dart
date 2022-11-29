import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';

abstract class LayoutDelegate {
  ScaffoldConfig get defaultConfig;

  Map<String, DynamicRouteLayout> buildLayouts(
    List<double> splits,
  );
}

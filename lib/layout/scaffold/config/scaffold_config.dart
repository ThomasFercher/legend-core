export 'package:legend_design_core/layout/scaffold/config/builders.dart';
export 'package:legend_design_core/layout/scaffold/config/whether.dart';

import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_design_core/layout/scaffold/config/builders.dart';
import 'package:legend_design_core/layout/scaffold/config/whether.dart';

class ScaffoldConfig {
  final ScaffoldBuilders? builders;
  final ScaffoldWhether? whether;
  final DynamicRouteLayout? layout;

  ScaffoldConfig({
    this.layout,
    this.builders,
    this.whether,
  });
}

export 'package:legend_design_core/layout/scaffold/config/builders.dart';
export 'package:legend_design_core/layout/scaffold/config/whether.dart';

import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_design_core/layout/scaffold/config/builders.dart';
import 'package:legend_design_core/layout/scaffold/config/whether.dart';

part 'scaffold_config.g.dart';

@LegendStyle()
abstract class ScaffoldConfigStyle {
  @LegendSubStyleField()
  final ScaffoldBuildersStyle builders;
  @LegendSubStyleField()
  final ScaffoldWhetherStyle whether;

  final DynamicRouteLayout layout;

  const ScaffoldConfigStyle({
    required this.builders,
    required this.whether,
    required this.layout,
  });
}

// flutter pub run build_runner build --delete-conflicting-outputs


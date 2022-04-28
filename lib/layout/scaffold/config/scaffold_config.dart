export 'package:legend_design_core/layout/scaffold/config/builders.dart';
export 'package:legend_design_core/layout/scaffold/config/sizing.dart';
export 'package:legend_design_core/layout/scaffold/config/whether.dart';

import 'package:legend_design_core/layout/scaffold/config/builders.dart';
import 'package:legend_design_core/layout/scaffold/config/sizing.dart';
import 'package:legend_design_core/layout/scaffold/config/whether.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';

class ScaffoldConfig {
  final LayoutType? layoutType;
  final ScaffoldBuilders? builders;
  final ScaffoldWhether? whether;
  final ScaffoldSizing? sizing;

  ScaffoldConfig({
    this.layoutType,
    this.builders,
    this.whether,
    this.sizing,
  });
}

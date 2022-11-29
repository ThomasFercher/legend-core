import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/sizing/core/override.dart';

abstract class SizingDelegate {
  const SizingDelegate();

  LegendSizing get defaultSizing;

  List<LegendSizingOverride>? get overrides;
}

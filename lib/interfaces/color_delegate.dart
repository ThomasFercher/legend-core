import 'package:legend_design_core/state/legend_state.dart';

abstract class ColorsDelegate {
  const ColorsDelegate();

  LegendPalette get darkTheme;

  LegendPalette get lightTheme;

  Map<String, LegendPalette>? get customThemes;
}

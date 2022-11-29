import 'package:legend_design_core/state/legend_state.dart';

import '../styles/colors/legend_color_theme.dart';

abstract class ColorsDelegate {
  const ColorsDelegate();

  LegendPalette get darkTheme;

  LegendPalette get lightTheme;

  Map<String, LegendPalette>? get customThemes;
}

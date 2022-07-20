import 'package:legend_design_core/styles/legend_theme.dart';

abstract class ThemeInterface {
  const ThemeInterface();

  LegendTypography buildTypography();
  LegendSizingTheme buildSizingTheme();
  LegendColorTheme buildColorTheme();
}

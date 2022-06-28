import 'package:legend_design_core/interfaces/subThemes.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/typography.dart';

import '../layout/scaffold/config/scaffold_config.dart';

abstract class ThemeInterface {
  const ThemeInterface();

  ScaffoldConfig Function(LegendTheme theme)? buildConfig();
  LegendTypography buildTypography();
  LegendSizingTheme buildSizingTheme();
  LegendColorTheme buildColorTheme();


}

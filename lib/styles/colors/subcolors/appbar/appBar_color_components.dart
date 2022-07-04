import 'package:legend_design_core/styles/colors/subcolors/micros/menu/menu_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';

class AppBarColorComponentsOverride {
  final MenuColorsOverride? menuColors;

  const AppBarColorComponentsOverride({
    this.menuColors,
  });
}

class AppBarColorComponents {
  final MenuColors menuColors;

  const AppBarColorComponents({
    required this.menuColors,
  });
}

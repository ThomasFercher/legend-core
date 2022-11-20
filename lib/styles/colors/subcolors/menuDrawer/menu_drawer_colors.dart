import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';

part 'menu_drawer_colors.g.dart';

@legendStyle
abstract class MenuDrawerColorsStyle {
  final Color background;
  final Color backgroundMenu;
  final Color foreground;
  final Color foregroundSelection;
  final Color backgroundSelection;
  final Color backgroundMenuSelection;
  final Color foregroundMenuSelection;
  @LegendSubStyle()
  final SideMenuColorsStyle menuColors;

  const MenuDrawerColorsStyle(
    this.background,
    this.backgroundMenu,
    this.foreground,
    this.foregroundSelection,
    this.backgroundSelection,
    this.backgroundMenuSelection,
    this.foregroundMenuSelection,
    this.menuColors,
  );
}

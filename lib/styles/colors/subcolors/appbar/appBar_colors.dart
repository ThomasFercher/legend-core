import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/menu/menu_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/tabbar/tabbar_colors.dart';

part 'appBar_colors.g.dart';

@legendStyle
abstract class AppBarColorsStyle {
  final Color background;
  final Color icon;
  final Color selected;
  final Color foreground;
  @LegendSubStyle()
  final MenuColorsStyle menuColors;
  @LegendSubStyle()
  final SideMenuColorsStyle subMenuColors;
  @LegendSubStyle()
  final TabbarColorsStyle? tabbarColors;

  const AppBarColorsStyle(
    this.background,
    this.icon,
    this.selected,
    this.foreground,
    this.menuColors,
    this.subMenuColors,
    this.tabbarColors,
  );
}

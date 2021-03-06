import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/menu/menu_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';

part 'appBar_colors.g.dart';

@generateStyle
abstract class AppBarColors {
  final Color background;
  final Color icon;
  final Color selected;
  final Color foreground;

  late final MenuColors menuColors;
  late final SideMenuColors subMenuColors;
  AppBarColors({
    required this.background,
    required this.icon,
    required this.selected,
    required this.foreground,
  });
}

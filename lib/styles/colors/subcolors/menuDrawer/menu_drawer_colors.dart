import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';

part 'menu_drawer_colors.g.dart';

@generateStyle
abstract class MenuDrawerColors {
  final Color background;
  final Color backgroundMenu;
  final Color foreground;
  final Color foreground_selection;
  final Color background_selection;
  final Color background_menu_selection;
  final Color foreground_menu_selction;

  late final SideMenuColors menuColors;

  MenuDrawerColors({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.foreground_selection,
    required this.background_selection,
    required this.background_menu_selection,
    required this.foreground_menu_selction,
    required this.menuColors,
  });
}

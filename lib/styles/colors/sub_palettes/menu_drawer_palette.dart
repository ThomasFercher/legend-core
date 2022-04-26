import 'package:flutter/widgets.dart';

import 'package:legend_design_core/utils/legend_utils.dart';

class MenuDrawerPalette {
  late final Color background;
  late final Color backgroundMenu;
  late final Color foreground;
  late final Color foreground_selection;
  late final Color background_selection;
  late final Color background_menu_selection;
  late final Color foreground_menu_selction;

  MenuDrawerPalette({
    Color? background,
    Color? backgroundMenu,
    Color? foreground,
    Color? foreground_selection,
    Color? background_selection,
    Color? background_menu_selection,
    Color? foreground_menu_selction,
  }) {
    this.background = background ?? nullColor;
    this.backgroundMenu = backgroundMenu ?? nullColor;
    this.foreground = foreground ?? nullColor;
    this.foreground_selection = foreground_selection ?? nullColor;
    this.foreground_menu_selction = foreground_menu_selction ?? nullColor;
    this.background_menu_selection = background_menu_selection ?? nullColor;
    this.background_selection = background_selection ?? nullColor;
  }

  factory MenuDrawerPalette.from({
    required MenuDrawerPalette? palette,
    required Color background,
    required Color backgroundMenu,
    required Color foreground,
    required Color foreground_selection,
    required Color background_selection,
    required Color background_menu_selection,
    required Color foreground_menu_selction,
  }) {
    if (palette == null) {
      return MenuDrawerPalette(
        background: background,
        backgroundMenu: backgroundMenu,
        foreground: foreground,
        foreground_selection: foreground_selection,
        background_menu_selection: background_menu_selection,
        background_selection: background_selection,
        foreground_menu_selction: foreground_menu_selction,
      );
    } else {
      return MenuDrawerPalette(
        background: LegendUtils.isNullColor(palette.background)
            ? background
            : palette.background,
        backgroundMenu: LegendUtils.isNullColor(palette.backgroundMenu)
            ? backgroundMenu
            : palette.backgroundMenu,
        foreground: LegendUtils.isNullColor(palette.foreground)
            ? foreground
            : palette.foreground,
        foreground_selection:
            LegendUtils.isNullColor(palette.foreground_selection)
                ? foreground_selection
                : palette.foreground_selection,
        background_menu_selection:
            LegendUtils.isNullColor(palette.background_menu_selection)
                ? background_menu_selection
                : palette.background_menu_selection,
        background_selection:
            LegendUtils.isNullColor(palette.background_selection)
                ? foreground_selection
                : palette.background_selection,
        foreground_menu_selction:
            LegendUtils.isNullColor(palette.foreground_menu_selction)
                ? foreground_menu_selction
                : palette.foreground_menu_selction,
      );
    }
  }
}

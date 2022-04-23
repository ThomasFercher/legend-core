import 'package:flutter/widgets.dart';
import 'package:legend_design_core/utils/legend_utils.dart';

class SiderPalette {
  late final Color background;
  late final Color backgroundMenu;
  late final Color foreground;
  late final Color selection;

  SiderPalette({
    Color? background,
    Color? backgroundMenu,
    Color? foreground,
    Color? selection,
  }) {
    this.background = background ?? nullColor;
    this.backgroundMenu = backgroundMenu ?? nullColor;
    this.foreground = foreground ?? nullColor;
    this.selection = selection ?? nullColor;
  }

  factory SiderPalette.from({
    required SiderPalette? siderPalette,
    required Color background,
    required Color backgroundMenu,
    required Color foreground,
    required Color selection,
  }) {
    if (siderPalette == null) {
      return SiderPalette(
        background: background,
        backgroundMenu: backgroundMenu,
        foreground: foreground,
        selection: selection,
      );
    } else {
      return SiderPalette(
        background: LegendUtils.isNullColor(siderPalette.background)
            ? background
            : siderPalette.background,
        backgroundMenu: LegendUtils.isNullColor(siderPalette.backgroundMenu)
            ? backgroundMenu
            : siderPalette.backgroundMenu,
        foreground: LegendUtils.isNullColor(siderPalette.foreground)
            ? foreground
            : siderPalette.foreground,
        selection: LegendUtils.isNullColor(siderPalette.selection)
            ? selection
            : siderPalette.selection,
      );
    }
  }
}

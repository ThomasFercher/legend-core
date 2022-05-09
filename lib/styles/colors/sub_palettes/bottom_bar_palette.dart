import 'package:flutter/widgets.dart';
import 'package:legend_utils/functions/functions.dart';

class BottomBarPalette {
  late final Color activeColor;
  late final Color disabledColor;
  late final Color backgroundColor;

  BottomBarPalette({
    Color? activeColor,
    Color? disabledColor,
    Color? backgroundColor,
  }) {
    this.activeColor = activeColor ?? nullColor;
    this.disabledColor = disabledColor ?? nullColor;
    this.backgroundColor = backgroundColor ?? nullColor;
  }

  factory BottomBarPalette.from({
    required BottomBarPalette? bottomBarPalette,
    required Color activeColor,
    required Color disabledColor,
    required Color backgroundColor,
  }) {
    if (bottomBarPalette == null) {
      return BottomBarPalette(
        activeColor: activeColor,
        disabledColor: disabledColor,
        backgroundColor: backgroundColor,
      );
    } else {
      return BottomBarPalette(
        activeColor: LegendFunctions.isNullColor(bottomBarPalette.activeColor)
            ? activeColor
            : bottomBarPalette.activeColor,
        disabledColor:
            LegendFunctions.isNullColor(bottomBarPalette.disabledColor)
                ? disabledColor
                : bottomBarPalette.disabledColor,
        backgroundColor:
            LegendFunctions.isNullColor(bottomBarPalette.backgroundColor)
                ? backgroundColor
                : bottomBarPalette.backgroundColor,
      );
    }
  }
}

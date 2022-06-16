import 'package:flutter/widgets.dart';
import 'package:legend_utils/functions/functions.dart';

abstract class BottomBarColorInfo {
  final Color? activeColor;
  final Color? disabledColor;
  final Color? backgroundColor;

  const BottomBarColorInfo({
    this.activeColor,
    this.disabledColor,
    this.backgroundColor,
  });
}

class BottomBarColorsOverride extends BottomBarColorInfo {
  const BottomBarColorsOverride({
    super.activeColor,
    super.disabledColor,
    super.backgroundColor,
  });
}

class BottomBarColors implements BottomBarColorInfo {
  @override
  final Color activeColor;
  @override
  final Color disabledColor;
  @override
  final Color backgroundColor;

  const BottomBarColors({
    required this.activeColor,
    required this.disabledColor,
    required this.backgroundColor,
  });

  factory BottomBarColors.override(
    BottomBarColors def,
    BottomBarColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return BottomBarColors(
      activeColor: override.activeColor ?? def.activeColor,
      disabledColor: override.disabledColor ?? def.disabledColor,
      backgroundColor: override.backgroundColor ?? def.backgroundColor,
    );
  }
}

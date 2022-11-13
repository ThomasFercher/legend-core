// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_colors.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class MenuColorsInfoNull {
  final Color? background;
  final Color? activeForeground;
  final Color? activeBackground;
  final Color? foreground;
  final Color? menuBackground;
  const MenuColorsInfoNull({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.menuBackground,
  });
}

abstract class MenuColorsInfo implements MenuColorsInfoNull {
  @override
  final Color background;
  @override
  final Color activeForeground;
  @override
  final Color activeBackground;
  @override
  final Color foreground;
  @override
  final Color menuBackground;
  const MenuColorsInfo({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.menuBackground,
  });
}

class MenuColorsOverride extends MenuColorsInfoNull {
  MenuColorsOverride({
    super.background,
    super.activeForeground,
    super.activeBackground,
    super.foreground,
    super.menuBackground,
  });
}

class MenuColorsStyle extends MenuColorsInfo {
  MenuColorsStyle({
    required super.background,
    required super.activeForeground,
    required super.activeBackground,
    required super.foreground,
    required super.menuBackground,
  });
  factory MenuColorsStyle.override(
    MenuColorsStyle def,
    MenuColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return MenuColorsStyle(
      background: override.background ?? def.background,
      activeForeground: override.activeForeground ?? def.activeForeground,
      activeBackground: override.activeBackground ?? def.activeBackground,
      foreground: override.foreground ?? def.foreground,
      menuBackground: override.menuBackground ?? def.menuBackground,
    );
  }
}

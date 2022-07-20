// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidemenu_colors.dart';

// **************************************************************************
// SubSizingGenerator
// **************************************************************************

abstract class SideMenuColorsInfoNull {
  final Color? background;
  final Color? activeForeground;
  final Color? activeBackground;
  final Color? foreground;
  final Color? menuBackground;
  const SideMenuColorsInfoNull({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.menuBackground,
  });
}

abstract class SideMenuColorsInfo implements SideMenuColorsInfoNull {
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
  const SideMenuColorsInfo({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.menuBackground,
  });
}

class SideMenuColorsOverride extends SideMenuColorsInfoNull {
  SideMenuColorsOverride({
    super.background,
    super.activeForeground,
    super.activeBackground,
    super.foreground,
    super.menuBackground,
  });
}

class SideMenuColorsStyle extends SideMenuColorsInfo {
  SideMenuColorsStyle({
    required super.background,
    required super.activeForeground,
    required super.activeBackground,
    required super.foreground,
    required super.menuBackground,
  });
  factory SideMenuColorsStyle.override(
    SideMenuColorsStyle def,
    SideMenuColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return SideMenuColorsStyle(
      background: override.background ?? def.background,
      activeForeground: override.activeForeground ?? def.activeForeground,
      activeBackground: override.activeBackground ?? def.activeBackground,
      foreground: override.foreground ?? def.foreground,
      menuBackground: override.menuBackground ?? def.menuBackground,
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidemenu_colors.dart';

// **************************************************************************
// StyleGenerator
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

class SideMenuColors extends SideMenuColorsInfo {
  SideMenuColors({
    required super.background,
    required super.activeForeground,
    required super.activeBackground,
    required super.foreground,
    required super.menuBackground,
  });
  SideMenuColors.copy({
    required super.background,
    required super.activeForeground,
    required super.activeBackground,
    required super.foreground,
    required super.menuBackground,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory SideMenuColors.override(
    SideMenuColors def,
    SideMenuColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return SideMenuColors(
      background: override.background ?? def.background,
      activeForeground: override.activeForeground ?? def.activeForeground,
      activeBackground: override.activeBackground ?? def.activeBackground,
      foreground: override.foreground ?? def.foreground,
      menuBackground: override.menuBackground ?? def.menuBackground,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  SideMenuColors copyWith({
    Color? background,
    Color? activeForeground,
    Color? activeBackground,
    Color? foreground,
    Color? menuBackground,
  }) {
    return SideMenuColors.copy(
      background: background ?? this.background,
      activeForeground: activeForeground ?? this.activeForeground,
      activeBackground: activeBackground ?? this.activeBackground,
      foreground: foreground ?? this.foreground,
      menuBackground: menuBackground ?? this.menuBackground,
    );
  }
}

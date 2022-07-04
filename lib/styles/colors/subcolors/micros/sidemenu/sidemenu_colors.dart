import 'dart:ui';

abstract class SideMenuColorInfoNull {
  final Color? background;
  final Color? activeForeground;
  final Color? activeBackground;
  final Color? foreground;
  final Color? menuBackground;

  const SideMenuColorInfoNull({
    this.background,
    this.activeForeground,
    this.activeBackground,
    this.foreground,
    this.menuBackground,
  });
}

abstract class SideMenuColorInfo implements SideMenuColorInfoNull {
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

  const SideMenuColorInfo({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.menuBackground,
  });
}

class SideMenuColorsOverride extends SideMenuColorInfoNull {
  const SideMenuColorsOverride({
    super.background,
    super.activeForeground,
    super.activeBackground,
    super.foreground,
    super.menuBackground,
  });
}

class SideMenuColors implements SideMenuColorInfo {
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
  @override
  const SideMenuColors({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.menuBackground,
  });

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
}

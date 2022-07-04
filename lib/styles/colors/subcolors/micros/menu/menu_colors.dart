import 'dart:ui';

abstract class MenuColorInfoNull {
  final Color? background;
  final Color? activeForeground;
  final Color? activeBackground;
  final Color? foreground;
  final Color? menuBackground;

  const MenuColorInfoNull({
    this.background,
    this.activeForeground,
    this.activeBackground,
    this.foreground,
    this.menuBackground,
  });
}

abstract class MenuColorInfo implements MenuColorInfoNull {
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

  const MenuColorInfo({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.menuBackground,
  });
}

class MenuColorsOverride extends MenuColorInfoNull {
  const MenuColorsOverride({
    super.background,
    super.activeForeground,
    super.activeBackground,
    super.foreground,
    super.menuBackground,
  });
}

class MenuColors implements MenuColorInfo {
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
  const MenuColors({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.menuBackground,
  });

  factory MenuColors.override(
    MenuColors def,
    MenuColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return MenuColors(
      background: override.background ?? def.background,
      activeForeground: override.activeForeground ?? def.activeForeground,
      activeBackground: override.activeBackground ?? def.activeBackground,
      foreground: override.foreground ?? def.foreground,
      menuBackground: override.menuBackground ?? def.menuBackground,
    );
  }
}

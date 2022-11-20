// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_drawer_colors.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class MenuDrawerColorsInfoNull {
  final Color? background;
  final Color? backgroundMenu;
  final Color? foreground;
  final Color? foregroundSelection;
  final Color? backgroundSelection;
  final Color? backgroundMenuSelection;
  final Color? foregroundMenuSelection;
  const MenuDrawerColorsInfoNull({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.foregroundSelection,
    required this.backgroundSelection,
    required this.backgroundMenuSelection,
    required this.foregroundMenuSelection,
  });
}

abstract class MenuDrawerColorsInfo implements MenuDrawerColorsInfoNull {
  @override
  final Color background;
  @override
  final Color backgroundMenu;
  @override
  final Color foreground;
  @override
  final Color foregroundSelection;
  @override
  final Color backgroundSelection;
  @override
  final Color backgroundMenuSelection;
  @override
  final Color foregroundMenuSelection;
  const MenuDrawerColorsInfo({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.foregroundSelection,
    required this.backgroundSelection,
    required this.backgroundMenuSelection,
    required this.foregroundMenuSelection,
  });
}

class MenuDrawerColorsComponentsInfo {
  final SideMenuColorsInfoNull? menuColors;
  MenuDrawerColorsComponentsInfo({
    this.menuColors,
  });
}

class MenuDrawerColorsComponentsOverride
    implements MenuDrawerColorsComponentsInfo {
  @override
  final SideMenuColorsOverride? menuColors;
  MenuDrawerColorsComponentsOverride({
    this.menuColors,
  });
}

class MenuDrawerColorsComponents implements MenuDrawerColorsComponentsInfo {
  @override
  final SideMenuColors menuColors;
  MenuDrawerColorsComponents({
    required this.menuColors,
  });
}

class MenuDrawerColorsOverride extends MenuDrawerColorsInfoNull
    implements MenuDrawerColorsComponentsOverride {
  final MenuDrawerColorsComponentsOverride Function(
      MenuDrawerColorsInfoNull sizing)? buildComponents;
  @override
  late final SideMenuColorsOverride? menuColors;
  MenuDrawerColorsOverride({
    this.buildComponents,
    super.background,
    super.backgroundMenu,
    super.foreground,
    super.foregroundSelection,
    super.backgroundSelection,
    super.backgroundMenuSelection,
    super.foregroundMenuSelection,
  }) {
    MenuDrawerColorsComponentsOverride? components =
        buildComponents?.call(this);
    menuColors = components?.menuColors;
  }
}

class MenuDrawerColors extends MenuDrawerColorsInfo
    implements MenuDrawerColorsComponents {
  @override
  late final SideMenuColors menuColors;
  MenuDrawerColors({
    required MenuDrawerColorsComponents Function(MenuDrawerColorsInfo sizing)
        buildComponents,
    required super.background,
    required super.backgroundMenu,
    required super.foreground,
    required super.foregroundSelection,
    required super.backgroundSelection,
    required super.backgroundMenuSelection,
    required super.foregroundMenuSelection,
  }) {
    MenuDrawerColorsComponents components = buildComponents.call(this);
    menuColors = components.menuColors;
  }
  MenuDrawerColors.copy({
    required super.background,
    required super.backgroundMenu,
    required super.foreground,
    required super.foregroundSelection,
    required super.backgroundSelection,
    required super.backgroundMenuSelection,
    required super.foregroundMenuSelection,
    required this.menuColors,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory MenuDrawerColors.override(
    MenuDrawerColors def,
    MenuDrawerColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return MenuDrawerColors(
      background: override.background ?? def.background,
      backgroundMenu: override.backgroundMenu ?? def.backgroundMenu,
      foreground: override.foreground ?? def.foreground,
      foregroundSelection:
          override.foregroundSelection ?? def.foregroundSelection,
      backgroundSelection:
          override.backgroundSelection ?? def.backgroundSelection,
      backgroundMenuSelection:
          override.backgroundMenuSelection ?? def.backgroundMenuSelection,
      foregroundMenuSelection:
          override.foregroundMenuSelection ?? def.foregroundMenuSelection,
      buildComponents: (_) {
        return MenuDrawerColorsComponents(
          menuColors:
              SideMenuColors.override(def.menuColors, override.menuColors),
        );
      },
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  MenuDrawerColors copyWith({
    Color? background,
    Color? backgroundMenu,
    Color? foreground,
    Color? foregroundSelection,
    Color? backgroundSelection,
    Color? backgroundMenuSelection,
    Color? foregroundMenuSelection,
    SideMenuColors? menuColors,
  }) {
    return MenuDrawerColors.copy(
      background: background ?? this.background,
      backgroundMenu: backgroundMenu ?? this.backgroundMenu,
      foreground: foreground ?? this.foreground,
      foregroundSelection: foregroundSelection ?? this.foregroundSelection,
      backgroundSelection: backgroundSelection ?? this.backgroundSelection,
      backgroundMenuSelection:
          backgroundMenuSelection ?? this.backgroundMenuSelection,
      foregroundMenuSelection:
          foregroundMenuSelection ?? this.foregroundMenuSelection,
      menuColors: menuColors ?? this.menuColors,
    );
  }
}

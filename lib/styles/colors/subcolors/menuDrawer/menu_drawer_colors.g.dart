// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_drawer_colors.dart';

// **************************************************************************
// SubSizingGenerator
// **************************************************************************

abstract class MenuDrawerColorsInfoNull {
  final Color? background;
  final Color? backgroundMenu;
  final Color? foreground;
  final Color? foreground_selection;
  final Color? background_selection;
  final Color? background_menu_selection;
  final Color? foreground_menu_selction;
  const MenuDrawerColorsInfoNull({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.foreground_selection,
    required this.background_selection,
    required this.background_menu_selection,
    required this.foreground_menu_selction,
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
  final Color foreground_selection;
  @override
  final Color background_selection;
  @override
  final Color background_menu_selection;
  @override
  final Color foreground_menu_selction;
  const MenuDrawerColorsInfo({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.foreground_selection,
    required this.background_selection,
    required this.background_menu_selection,
    required this.foreground_menu_selction,
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
  final SideMenuColorsStyle menuColors;
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
    super.foreground_selection,
    super.background_selection,
    super.background_menu_selection,
    super.foreground_menu_selction,
  }) {
    MenuDrawerColorsComponentsOverride? components =
        buildComponents?.call(this);
    menuColors = components?.menuColors;
  }
}

class MenuDrawerColorsStyle extends MenuDrawerColorsInfo
    implements MenuDrawerColorsComponents {
  final MenuDrawerColorsComponents Function(MenuDrawerColorsInfo sizing)
      buildComponents;
  @override
  late final SideMenuColorsStyle menuColors;
  MenuDrawerColorsStyle({
    required this.buildComponents,
    required super.background,
    required super.backgroundMenu,
    required super.foreground,
    required super.foreground_selection,
    required super.background_selection,
    required super.background_menu_selection,
    required super.foreground_menu_selction,
  }) {
    MenuDrawerColorsComponents components = buildComponents.call(this);
    menuColors = components.menuColors;
  }
  factory MenuDrawerColorsStyle.override(
    MenuDrawerColorsStyle def,
    MenuDrawerColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return MenuDrawerColorsStyle(
      background: override.background ?? def.background,
      backgroundMenu: override.backgroundMenu ?? def.backgroundMenu,
      foreground: override.foreground ?? def.foreground,
      foreground_selection:
          override.foreground_selection ?? def.foreground_selection,
      background_selection:
          override.background_selection ?? def.background_selection,
      background_menu_selection:
          override.background_menu_selection ?? def.background_menu_selection,
      foreground_menu_selction:
          override.foreground_menu_selction ?? def.foreground_menu_selction,
      buildComponents: (_) {
        return MenuDrawerColorsComponents(
          menuColors:
              SideMenuColorsStyle.override(def.menuColors, override.menuColors),
        );
      },
    );
  }
}

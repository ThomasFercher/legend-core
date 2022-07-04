import 'package:flutter/widgets.dart';
import 'package:legend_design_core/styles/colors/subcolors/menuDrawer/menu_drawer_colors_components.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';

import 'package:legend_utils/functions/functions.dart';

abstract class MenuDrawerColorInfo implements MenuDrawerColorInfoNull {
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

  const MenuDrawerColorInfo({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.foreground_selection,
    required this.background_selection,
    required this.background_menu_selection,
    required this.foreground_menu_selction,
  });
}

abstract class MenuDrawerColorInfoNull {
  final Color? background;
  final Color? backgroundMenu;
  final Color? foreground;
  final Color? foreground_selection;
  final Color? background_selection;
  final Color? background_menu_selection;
  final Color? foreground_menu_selction;

  const MenuDrawerColorInfoNull({
    this.background,
    this.backgroundMenu,
    this.foreground,
    this.foreground_selection,
    this.background_selection,
    this.background_menu_selection,
    this.foreground_menu_selction,
  });
}

class MenuDrawerColorOverride extends MenuDrawerColorInfoNull
    implements MenuDrawerColorComponentsOverride {
  @override
  late final SideMenuColorsOverride? sideMenuColors;

  final MenuDrawerColorComponentsOverride Function(
      MenuDrawerColorInfoNull colors)? buildComponents;

  MenuDrawerColorOverride({
    super.background,
    super.backgroundMenu,
    super.foreground,
    super.foreground_selection,
    super.background_selection,
    super.background_menu_selection,
    super.foreground_menu_selction,
    this.buildComponents,
  }) {
    MenuDrawerColorComponentsOverride? components = buildComponents?.call(this);
    sideMenuColors = components?.sideMenuColors;
  }
}

class MenuDrawerColors
    implements MenuDrawerColorInfo, MenuDrawerColorComponents {
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

  @override
  late final SideMenuColors sideMenuColors;

  final MenuDrawerColorComponents Function(MenuDrawerColorInfo colors)
      buildComponents;

  MenuDrawerColors({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.foreground_selection,
    required this.background_selection,
    required this.background_menu_selection,
    required this.foreground_menu_selction,
    required this.buildComponents,
  }) {
    MenuDrawerColorComponents components = buildComponents.call(this);
    sideMenuColors = components.sideMenuColors;
  }

  factory MenuDrawerColors.override(
    MenuDrawerColors def,
    MenuDrawerColorOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return MenuDrawerColors(
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
        return MenuDrawerColorComponents(
          sideMenuColors: SideMenuColors.override(
            def.sideMenuColors,
            override.sideMenuColors,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/colors/subcolors/appbar/appBar_color_components.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/menu/menu_colors.dart';
import 'package:legend_utils/functions/functions.dart';

abstract class AppBarColorInfo implements AppBarColorInfoNull {
  @override
  final Color background;
  @override
  final Color icon;
  @override
  final Color selected;
  @override
  final Color foreground;

  AppBarColorInfo({
    required this.background,
    required this.icon,
    required this.selected,
    required this.foreground,
  });
}

abstract class AppBarColorInfoNull {
  final Color? background;
  final Color? icon;
  final Color? selected;
  final Color? foreground;

  AppBarColorInfoNull({
    this.background,
    this.icon,
    this.selected,
    this.foreground,
  });
}

class AppBarColorsOverride extends AppBarColorInfoNull
    implements AppBarColorComponentsOverride {
  @override
  late final MenuColorsOverride? menuColors;

  final AppBarColorComponentsOverride Function(AppBarColorInfoNull colors)?
      buildComponents;

  AppBarColorsOverride({
    super.background,
    super.icon,
    super.selected,
    super.foreground,
    this.buildComponents,
  }) {
    AppBarColorComponentsOverride? components = buildComponents?.call(this);
    menuColors = components?.menuColors;
  }
}

class AppBarColors implements AppBarColorInfo, AppBarColorComponents {
  @override
  final Color background;
  @override
  final Color icon;
  @override
  final Color selected;
  @override
  final Color foreground;

  @override
  late final MenuColors menuColors;

  final AppBarColorComponents Function(AppBarColorInfo colors) buildComponents;

  factory AppBarColors.override(
    AppBarColors def,
    AppBarColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return AppBarColors(
      background: override.background ?? def.background,
      icon: override.icon ?? def.icon,
      selected: override.selected ?? def.selected,
      foreground: override.foreground ?? def.foreground,
      buildComponents: (_) {
        return AppBarColorComponents(
          menuColors: MenuColors.override(def.menuColors, override.menuColors),
        );
      },
    );
  }

  AppBarColors({
    required this.background,
    required this.icon,
    required this.selected,
    required this.foreground,
    required this.buildComponents,
  }) {
    AppBarColorComponents components = buildComponents(this);
    menuColors = components.menuColors;
  }
}

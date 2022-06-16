import 'package:flutter/material.dart';
import 'package:legend_utils/functions/functions.dart';

abstract class AppBarColorInfo {
  final Color? background;
  final Color? icon;
  final Color? selected;
  final Color? foreground;
  final Color? card;

  AppBarColorInfo({
    this.background,
    this.icon,
    this.selected,
    this.foreground,
    this.card,
  });
}

class AppBarColorsOverride extends AppBarColorInfo {
  AppBarColorsOverride({
    super.background,
    super.icon,
    super.selected,
    super.foreground,
    super.card,
  });
}

class AppBarColors implements AppBarColorInfo {
  @override
  final Color background;
  @override
  final Color icon;
  @override
  final Color selected;
  @override
  final Color foreground;
  @override
  final Color? card;

  factory AppBarColors.cardStyle({
    required Color background,
    required Color icon,
    required Color selected,
    required Color foreground,
    required Color card,
  }) {
    return AppBarColors(
      background: background,
      icon: icon,
      selected: selected,
      foreground: foreground,
      card: card,
    );
  }

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
      card: override.card ?? def.card,
    );
  }

  const AppBarColors({
    required this.background,
    required this.icon,
    required this.selected,
    required this.foreground,
    this.card,
  });
}

import 'package:flutter/material.dart';
import 'package:legend_utils/functions/functions.dart';

class AppBarPalette {
  late final Color background;
  late final Color icon;
  late final Color selected;
  late final Color foreground;
  late final Color? card;

  factory AppBarPalette.cardStyle({
    required Color background,
    required Color icon,
    required Color selected,
    required Color foreground,
    required Color card,
  }) {
    return AppBarPalette(
      background: background,
      icon: icon,
      selected: selected,
      foreground: foreground,
      card: card,
    );
  }

  factory AppBarPalette.from({
    required AppBarPalette? appBarPalette,
    required Color background,
    required Color icon,
    required Color selected,
    required Color foreground,
    Color? card,
  }) {
    if (appBarPalette == null) {
      return AppBarPalette(
        background: background,
        icon: icon,
        selected: selected,
        foreground: foreground,
        card: card,
      );
    }
    return AppBarPalette(
      background: LegendFunctions.isNullColor(appBarPalette.background)
          ? background
          : appBarPalette.background,
      icon: LegendFunctions.isNullColor(appBarPalette.icon)
          ? icon
          : appBarPalette.icon,
      selected: LegendFunctions.isNullColor(appBarPalette.selected)
          ? selected
          : appBarPalette.selected,
      foreground: LegendFunctions.isNullColor(appBarPalette.foreground)
          ? foreground
          : appBarPalette.foreground,
      card: appBarPalette.card,
    );
  }

  AppBarPalette({
    Color? background,
    Color? icon,
    Color? selected,
    Color? foreground,
    Color? card,
  }) {
    this.background = background ?? nullColor;
    this.icon = icon ?? nullColor;
    this.selected = selected ?? nullColor;
    this.foreground = foreground ?? nullColor;
    this.card = card;
  }
}

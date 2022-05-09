// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/colors/sub_palettes/app_bar_palette.dart';
import 'package:legend_design_core/styles/colors/sub_palettes/bottom_bar_palette.dart';
import 'package:legend_design_core/styles/colors/sub_palettes/footer_palette.dart';
import 'package:legend_design_core/styles/colors/sub_palettes/menu_drawer_palette.dart';
import 'package:legend_design_core/styles/colors/sub_palettes/sider_palette.dart';
import 'package:legend_design_core/styles/typography/typography.dart';

import 'package:legend_utils/extensions/extensions.dart';

class LegendPalette {
  ///  Primary Color
  final Color primary;

  ///  Secondary Color
  final Color secondary;

  ///  Tertiary Color
  final Color tertiary;

  /// Foreground colors. The color get darker with each index. The foreground Color
  /// of the index should work on the background color from the same index
  final List<Color> foreground;

  /// Background colors. The color get brighter with each index. The foreground Color
  /// of the index should work on the background color from the same index
  final List<Color> background;

  /// Error Color
  final Color error;

  /// Disabled Color
  final Color disabled;

  /// Shadow Color
  final Color shadow;

  /// Selection Color. For example a selected Button will change to this color.
  final Color selection;

  /// Textcolor on dark background
  final Color textOnDark;

  /// Textcolor on light background
  final Color textOnLight;

  /// Color ontop of the Primary Color
  final Color onPrimary;

  /// Color ontop of the Secondary Color
  final Color onSecondary;

  /// Color ontop of the Tertiary Color
  final Color onTertiary;

  // Sub Themes which are not required.
  // These Themes, if null, will get generated with the required colors.

  /// Footer Color Palette
  late final FooterPalette footerPalette;

  /// AppBar Color Palette
  late final AppBarPalette appBarPalette;

  /// Sider Color Palette
  late final SiderPalette siderPalette;

  /// BottomBar Color Palette
  late final BottomBarPalette bottomBarPalette;

  /// Typography Color Palette
  late final TypographyColors typographyColors;

  /// Typography Color Palette
  late final MenuDrawerPalette menuDrawerPalette;

  /// Custom Color Palette for the whole Application
  /// Each Color is overridable in each single Widget
  LegendPalette({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.foreground,
    required this.background,
    required this.error,
    required this.disabled,
    required this.shadow,
    required this.selection,
    required this.textOnDark,
    required this.textOnLight,
    required this.onPrimary,
    required this.onSecondary,
    required this.onTertiary,
    TypographyColors? typographyColors,
    FooterPalette? footerPalette,
    AppBarPalette? appBarPalette,
    SiderPalette? siderPalette,
    BottomBarPalette? bottomBarPalette,
    MenuDrawerPalette? menuDrawerPalette,
  }) {
    // Typography
    typographyColors ??= TypographyColors(baseColor: textOnDark);
    this.typographyColors = typographyColors;

    // Footer
    this.footerPalette = FooterPalette.from(
      footerPalette: footerPalette,
      background: background[1],
      foreground: foreground[1],
    );

    // AppBar
    this.appBarPalette = AppBarPalette.from(
      appBarPalette: appBarPalette,
      background: primary,
      icon: onPrimary,
      selected: selection,
      foreground: onPrimary,
    );

    // BottomBar
    this.bottomBarPalette = BottomBarPalette.from(
      bottomBarPalette: bottomBarPalette,
      backgroundColor: foreground[0],
      activeColor: selection,
      disabledColor: disabled,
    );

    // Sider
    this.siderPalette = SiderPalette.from(
      siderPalette: siderPalette,
      foreground: onPrimary,
      background: primary,
      backgroundMenu: primary,
      selection: selection,
    );

    // Menu Drawer
    this.menuDrawerPalette = MenuDrawerPalette.from(
      palette: menuDrawerPalette,
      background: primary,
      backgroundMenu: primary,
      foreground: onPrimary,
      foreground_selection: selection,
      foreground_menu_selction: selection,
      background_menu_selection: primary.darken(0.2),
      background_selection: primary.darken(),
    );
  }
}

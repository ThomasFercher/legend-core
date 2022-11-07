// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/colors/subcolors/appbar/appBar_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/bottomBar/bottom_bar_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/footer/footer_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/menuDrawer/menu_drawer_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/sider/sider_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/sub_colors.dart';
import 'package:legend_design_core/styles/typography/style/typography_colors.dart';
import 'package:legend_design_core/styles/typography/typography.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'core_colors.dart';
import 'subcolors/micros/menu/menu_colors.dart';
import 'subcolors/micros/tabbar/tabbar_colors.dart';

class LegendPalette implements LegendCoreColors {
  ///  Primary Color
  @override
  final Color primary;

  ///  Secondary Color
  @override
  final Color secondary;

  ///  Tertiary Color
  @override
  final Color tertiary;

  /// Foreground colors. The color get darker with each index. The foreground Color
  /// of the index should work on the background color from the same index
  @override
  final Color foreground1;
  @override
  final Color foreground2;
  @override
  final Color foreground3;
  @override
  final Color foreground4;
  @override
  final Color foreground5;

  /// Background colors. The color get brighter with each index. The foreground Color
  /// of the index should work on the background color from the same index
  @override
  final Color background1;
  @override
  final Color background2;
  @override
  final Color background3;
  @override
  final Color background4;
  @override
  final Color background5;

  /// Error Color
  @override
  final Color error;

  /// Disabled Color
  @override
  final Color disabled;

  /// Selection Color. For example a selected Button will change to this color.
  @override
  final Color selection;

  /// Color ontop of the Primary Color
  @override
  final Color onPrimary;

  /// Color ontop of the Secondary Color
  @override
  final Color onSecondary;

  /// Color ontop of the Tertiary Color
  @override
  final Color onTertiary;

  @override
  late final Map<String, Color> custom;

  ///
  /// Returns a Color from the [Map<String, Color>]. If the key is not found, the primary color will be returned.
  /// Or if the [else] Colors is defined it will be returned.
  ///
  Color get(String key, {Color? notFound}) {
    if (custom.containsKey(key)) {
      return custom[key]!;
    } else {
      return notFound ?? primary;
    }
  }

  // Sub Themes which are not required.
  // These Themes, if null, will get generated with the required colors.

  /// Footer Color Palette
  late final FooterColorsStyle footer;

  /// AppBar Color Palette
  late final AppBarColorsStyle appBar;

  /// Sider Color Palette
  late final SiderColorsStyle sider;

  /// BottomBar Color Palette
  late final BottomBarColorsStyle bottomBar;

  /// Typography Color Palette
  late final TypographyColorsStyle typography;

  /// Typography Color Palette
  late final MenuDrawerColorsStyle menuDrawer;

  final LegendSubColors Function(LegendCoreColors colors)? subcolors;

  /// Custom Color Palette for the whole Application
  /// Each Color is overridable in each single Widget
  LegendPalette({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.onPrimary,
    required this.onSecondary,
    required this.onTertiary,
    required this.error,
    required this.disabled,
    required this.selection,
    required this.foreground1,
    required this.foreground2,
    required this.foreground3,
    required this.foreground4,
    required this.foreground5,
    required this.background1,
    required this.background2,
    required this.background3,
    required this.background4,
    required this.background5,
    this.subcolors,
    Map<String, Color>? custom,
  }) {
    // Custom Colors
    this.custom = custom ?? {};

    // Sub Colors
    LegendSubColors subColors = subcolors?.call(this) ?? LegendSubColors();

    // Typography
    TypographyColorsStyle typographyColors = TypographyColorsStyle(
      h0: foreground1,
      h1: foreground2,
      h2: foreground3,
      h3: foreground4,
      h4: foreground5,
      h5: foreground5,
    );
    typography =
        TypographyColorsStyle.override(typographyColors, subColors.typography);

    // Footer
    FooterColorsStyle footerColors = FooterColorsStyle(
      background: background4,
      foreground: foreground4,
    );
    footer = FooterColorsStyle.override(footerColors, subColors.footer);

    // AppBar
    AppBarColorsStyle appBarColors = AppBarColorsStyle(
      background: primary,
      icon: foreground1,
      selected: selection,
      foreground: foreground1,
      buildComponents: (AppBarColorsInfo colors) {
        return AppBarColorsComponents(
          menuColors: MenuColorsStyle(
            activeBackground: colors.background.lighten(),
            activeForeground: colors.selected,
            background: colors.background,
            foreground: colors.foreground,
            menuBackground: colors.background,
          ),
          subMenuColors: SideMenuColorsStyle(
            activeBackground: colors.background.lighten(),
            activeForeground: colors.selected,
            background: colors.background,
            foreground: colors.foreground,
            menuBackground: colors.background,
          ),
          tabbarColors: TabbarColorsStyle(
            background: colors.foreground,
          ),
        );
      },
    );
    appBar = AppBarColorsStyle.override(appBarColors, subColors.appBar);

    // BottomBar
    BottomBarColorsStyle bottomBarColors = BottomBarColorsStyle(
      backgroundColor: background1,
      activeColor: selection,
      disabledColor: disabled,
    );
    bottomBar =
        BottomBarColorsStyle.override(bottomBarColors, subColors.bottomBar);

    // Sider
    SiderColorsStyle siderColors = SiderColorsStyle(
        background: background1,
        foreground: foreground1,
        selection: selection,
        backgroundMenu: background1,
        buildComponents: (colors) {
          return SiderColorsComponents(
            menuColors: SideMenuColorsStyle(
              background: colors.background,
              activeForeground: colors.selection,
              activeBackground: colors.background.lighten(),
              foreground: colors.foreground,
              menuBackground: colors.backgroundMenu,
            ),
          );
        });
    sider = SiderColorsStyle.override(siderColors, subColors.sider);

    // Menu Drawer
    MenuDrawerColorsStyle menuDrawerColors = MenuDrawerColorsStyle(
      background: primary,
      backgroundMenu: onPrimary,
      background_menu_selection: onPrimary.lighten(),
      background_selection: onPrimary,
      foreground: foreground1,
      foreground_menu_selction: selection,
      foreground_selection: selection,
      buildComponents: (MenuDrawerColorsInfo colors) {
        return MenuDrawerColorsComponents(
          menuColors: SideMenuColorsStyle(
            activeBackground: colors.background.lighten(),
            activeForeground: colors.foreground_selection,
            background: colors.background,
            foreground: colors.foreground,
            menuBackground: colors.backgroundMenu,
          ),
        );
      },
    );
    menuDrawer = MenuDrawerColorsStyle.override(
      menuDrawerColors,
      subColors.menuDrawer,
    );
  }
}

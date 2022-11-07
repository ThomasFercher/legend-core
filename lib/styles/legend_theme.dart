import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/colors/subcolors/menuDrawer/menu_drawer_colors.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/theme_provider.dart';
import 'package:provider/provider.dart';
import 'colors/legend_palette.dart';
import 'colors/subcolors/appbar/appBar_colors.dart';
import 'colors/subcolors/bottomBar/bottom_bar_colors.dart';
import 'colors/subcolors/footer/footer_colors.dart';
import 'colors/subcolors/sider/sider_colors.dart';
import 'sizing/core/legend_sizing.dart';

export 'colors/legend_color_theme.dart';
export 'colors/legend_palette.dart';
export 'colors/subcolors/appbar/appBar_colors.dart';
export 'colors/subcolors/bottomBar/bottom_bar_colors.dart';
export 'colors/subcolors/footer/footer_colors.dart';
export 'colors/subcolors/sider/sider_colors.dart';
export 'sizing/core/legend_sizing.dart';
export 'sizing/legend_sizing_theme.dart';
export 'sizing/sub_sizing/appbar/appBar_sizing.dart';

///
///
///
///
@immutable
class LegendTheme {
  /// Class containing a list of different Textstyles
  final LegendTypography typography;

  /// Color Theme for the whole applications. Contains a List of [LegendPalette]
  final LegendPalette colors;

  /// Sizing Theme for the whole applications. Contains a List of [LegendSizing] for multiple
  /// Screen Resolutions and platforms.

  /// Gets the current [LegendSizing]
  final LegendSizing sizing;

  // Getters for simplified access to sub themes
  AppBarColorsStyle get appBarColors => colors.appBar;
  BottomBarColorsStyle get bottomBarColors => colors.bottomBar;
  FooterColorsStyle get footerColors => colors.footer;
  SiderColorsStyle get siderColors => colors.sider;
  MenuDrawerColorsStyle get menuDrawerColors => colors.menuDrawer;

  AppBarSizingStyle get appBarSizing => sizing.appBarSizing;
  BottomBarSizingStyle get bottomBarSizing => sizing.bottomBarSizing;
  FooterSizingStyle get footerSizing => sizing.footerSizing;
  SiderSizingStyle get siderSizing => sizing.siderSizing;
  MenuDrawerSizingStyle get menuDrawerSizing => sizing.menuDrawerSizing;

  /// Returns the splits of the Sizing Theme as a List
  final List<double> splits;

  /// A global Theme for Legendscaffold which which be used every unless overwritten locally
  final ScaffoldConfig scaffoldConfig;

  const LegendTheme({
    required this.scaffoldConfig,
    required this.colors,
    required this.sizing,
    required this.splits,
    required this.typography,
  });

  LegendTheme copyWith({LegendSizing? sizing, LegendPalette? colors}) {
    final LegendPalette _colors = colors ?? this.colors;
    final LegendSizing _sizing = sizing ?? this.sizing;

    return LegendTheme(
      scaffoldConfig: scaffoldConfig,
      colors: _colors,
      sizing: _sizing,
      splits: splits,
      typography: LegendTypography.applyStyles(
        base: typography,
        sizing: _sizing.typographySizing,
        colors: _colors.typography,
      ),
    );
  }

  static LegendTheme of(BuildContext context) {
    return context.watch<ThemeProvider>().theme;
  }
}

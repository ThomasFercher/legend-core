import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/styles/colors/sub_palettes/menu_drawer_palette.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_design_core/styles/typography/typography.dart';
import 'package:legend_utils/legend_utils.dart';
import 'colors/legend_color_theme.dart';
import 'colors/legend_palette.dart';
import 'colors/sub_palettes/app_bar_palette.dart';
import 'colors/sub_palettes/bottom_bar_palette.dart';
import 'colors/sub_palettes/footer_palette.dart';
import 'colors/sub_palettes/sider_palette.dart';
import 'sizing/legend_sizing.dart';
import 'sizing/legend_sizing_theme.dart';
import 'sizing/sub_sizing/menu_drawer_sizing.dart';
import 'sizing/sub_sizing/sider_sizing.dart';

export 'colors/legend_color_theme.dart';
export 'colors/legend_palette.dart';
export 'colors/sub_palettes/app_bar_palette.dart';
export 'colors/sub_palettes/bottom_bar_palette.dart';
export 'colors/sub_palettes/footer_palette.dart';
export 'colors/sub_palettes/sider_palette.dart';
export 'sizing/legend_sizing.dart';
export 'sizing/legend_sizing_theme.dart';
export 'sizing/sub_sizing/app_bar_sizing.dart';

class LegendTheme extends ChangeNotifier {
  ///
  /// Class containing a list of different Textstyles
  ///
  late final LegendTypography typography;

  ///
  /// Color Theme for the whole applications. Contains a List of [LegendPalette]
  ///
  final LegendColorTheme colorTheme;

  /// Gets the currently selected [LegendPalette]
  LegendPalette get colors => colorTheme.current;

  /// Gets the current [AppBarPalette]
  AppBarPalette get appBarPalette => colors.appBarPalette;

  /// Gets the current [BottomBarPalette]
  BottomBarPalette get bottomBarPalette => colors.bottomBarPalette;

  /// Gets the current [FooterPalette]
  FooterPalette get footerPalette => colors.footerPalette;

  /// Gets the current [SiderPalette]
  SiderPalette get siderPalette => colors.siderPalette;

  /// Gets the current [MenuDrawerPalette]
  MenuDrawerPalette get menuDrawerPalette => colors.menuDrawerPalette;

  ///
  /// Sizing Theme for the whole applications. Contains a List of [LegendSizing] for multiple
  /// Screen Resolutions and platforms.
  ///
  late final LegendSizingTheme _sizingTheme;
  LegendSizingTheme get sizingTheme => _sizingTheme;

  /// Gets the current [LegendSizing]
  LegendSizing get sizing => _sizingTheme.sizing;

  AppBarSizing get appBarSizing => sizing.appBarSizing;

  BottomBarSizing? get bottomBarSizing => sizing.bottomBarSizing;

  SiderSizing get siderSizing => sizing.siderSizing;

  /// Gets the current [MenuDrawerSizing]
  MenuDrawerSizing get menuDrawerSizing => sizing.menuDrawerSizing;

  /// Returns the splits of the Sizing Theme as a List
  List<double> get splits => List.of(_sizingTheme.sizings.keys);

  final bool _menuCollapsed = false;
  bool get menuCollapsed => _menuCollapsed;

  ///
  /// A global Theme for Legendscaffold which which be used every unless overwritten locally
  ///
  late final ScaffoldConfig? scaffoldConfig;
  final ScaffoldConfig Function(LegendTheme theme)? buildConfig;

  ///
  /// A bool whether the platform is Mobile. Does not depend on the screen dimensions.
  ///
  late final bool _isMobile;
  bool get isMobile => _isMobile;

  LegendTheme({
    this.buildConfig,
    required this.colorTheme,
    required LegendSizingTheme sizingTheme,
    required LegendTypography typography,
  }) {
    _sizingTheme = sizingTheme;

    _isMobile = PlatformInfo.isMobile;

    // The typography gets initalized in the body cause it depends on both the color and sizing Theme.
    this.typography = LegendTypography.applyStyles(
      sizing: sizing.typographySizing,
      colors: colors.typographyColors,
      typography: typography,
    );

    systemUIOverrides();

    if (buildConfig != null) {
      scaffoldConfig = buildConfig!(this);
    } else {
      scaffoldConfig = null;
    }
  }

  /// System UI Overrides. This is used to change the colors of the status bar and navigation bar
  void systemUIOverrides() {
    // If there is a bottom bar, set color to the background Color of the bottom bar
    // else use the first background color.
    Color _systemNavigationBarColor = sizing.showBottomBar
        ? bottomBarPalette.backgroundColor
        : colors.background[0];

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: _systemNavigationBarColor,
      ),
    );
  }

  /// Changes the current [LegendPalette] responding to the [type]
  /// The LegendTypography will be updated accordingly and the App will
  /// restart.
  void changeColorTheme(PaletteType type, BuildContext context) {
    colorTheme.setType(type);

    updateTypography();
    notifyListeners();
    RestartWidget.restartApp(context);
  }

  /// Applies Sizing and Colors to the Typography
  void updateTypography() {
    typography = LegendTypography.applyStyles(
      sizing: sizing.typographySizing,
      colors: colors.typographyColors,
      typography: typography,
    );
  }
}

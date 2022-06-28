import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/styles/colors/subcolors/menu_drawer_colors.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_design_core/styles/typography/typography.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_utils/legend_utils.dart';
import 'colors/legend_color_theme.dart';
import 'colors/legend_palette.dart';
import 'colors/subcolors/appBar_colors.dart';
import 'colors/subcolors/bottom_bar_colors.dart';
import 'colors/subcolors/footer_colors.dart';
import 'colors/subcolors/sider_colors.dart';
import 'sizing/core/legend_sizing.dart';
import 'sizing/legend_sizing_theme.dart';
import 'sizing/sub_sizing/menu_drawer_sizing.dart';
import 'sizing/sub_sizing/sider_sizing.dart';

export 'colors/legend_color_theme.dart';
export 'colors/legend_palette.dart';
export 'colors/subcolors/appBar_colors.dart';
export 'colors/subcolors/bottom_bar_colors.dart';
export 'colors/subcolors/footer_colors.dart';
export 'colors/subcolors/sider_colors.dart';
export 'sizing/core/legend_sizing.dart';
export 'sizing/legend_sizing_theme.dart';
export 'sizing/sub_sizing/app_bar_sizing.dart';

class LegendTheme extends ChangeNotifier {
  ///
  /// Class containing a list of different Textstyles
  ///
  late LegendTypography typography;

  ///
  /// Color Theme for the whole applications. Contains a List of [LegendPalette]
  ///
  final LegendColorTheme colorTheme;

  /// Gets the currently selected [LegendPalette]
  LegendPalette get colors => colorTheme.current;

  /// Gets the current [AppBarColors]
  AppBarColors get appBar => colors.appBar;

  /// Gets the current [BottomBarColors]
  BottomBarColors get bottomBarPalette => colors.bottomBar;

  /// Gets the current [FooterColors]
  FooterColors get footerPalette => colors.footer;

  /// Gets the current [SiderColors]
  SiderColors get siderPalette => colors.sider;

  /// Gets the current [MenuDrawerColors]
  MenuDrawerColors get menuDrawerPalette => colors.menuDrawer;

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
  List<double> get splits => _sizingTheme.splits;

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
      colors: colors.typography,
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: colorTheme.current.bottomBar.backgroundColor,
      ),
    );
  }

  /// Changes the current [LegendPalette] responding to the [type]
  /// The LegendTypography will be updated accordingly and the App will
  /// restart.
  void changeColorTheme(PaletteType type, BuildContext context) {
    colorTheme.setType(type);

    systemUIOverrides();
    updateTypography();
    notifyListeners();

    RestartWidget.restartApp(context);
  }

  /// Applies Sizing and Colors to the Typography
  void updateTypography() {
    typography = LegendTypography.applyStyles(
      sizing: sizing.typographySizing,
      colors: colors.typography,
      typography: typography,
    );
  }
}

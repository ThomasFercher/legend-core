import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/styles/colors/subcolors/menuDrawer/menu_drawer_colors.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_utils/legend_utils.dart';
import 'colors/legend_color_theme.dart';
import 'colors/legend_palette.dart';
import 'colors/subcolors/appbar/appBar_colors.dart';
import 'colors/subcolors/bottomBar/bottom_bar_colors.dart';
import 'colors/subcolors/footer/footer_colors.dart';
import 'colors/subcolors/sider/sider_colors.dart';
import 'sizing/core/legend_sizing.dart';
import 'sizing/legend_sizing_theme.dart';

export 'colors/legend_color_theme.dart';
export 'colors/legend_palette.dart';
export 'colors/subcolors/appbar/appBar_colors.dart';
export 'colors/subcolors/bottomBar/bottom_bar_colors.dart';
export 'colors/subcolors/footer/footer_colors.dart';
export 'colors/subcolors/sider/sider_colors.dart';
export 'sizing/core/legend_sizing.dart';
export 'sizing/legend_sizing_theme.dart';
export 'sizing/sub_sizing/appbar/appBar_sizing.dart';
export 'package:provider/provider.dart';

///
///
///
class LegendTheme extends ChangeNotifier {
  /// Class containing a list of different Textstyles
  late LegendTypography typography;

  /// Color Theme for the whole applications. Contains a List of [LegendPalette]
  final LegendColorTheme colorTheme;
  LegendPalette get colors => colorTheme.current;

  /// Sizing Theme for the whole applications. Contains a List of [LegendSizing] for multiple
  /// Screen Resolutions and platforms.
  final LegendSizingTheme sizingTheme;

  /// Gets the current [LegendSizing]
  LegendSizing get sizing => sizingTheme.sizing;

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
  List<double> get splits => sizingTheme.splits;

  /// A global Theme for Legendscaffold which which be used every unless overwritten locally
  late final ScaffoldConfig? scaffoldConfig;
  final ScaffoldConfig Function(LegendTheme theme)? buildConfig;

  LegendTheme({
    this.buildConfig,
    required this.colorTheme,
    required this.sizingTheme,
    required LegendTypography typography,
  }) {
    // Whenever the SizingTheme changes we have to update the Typography
    sizingTheme.sizingChanged.listen((event) => changeSizingTheme());

    // The typography gets initalized in the body cause it depends on both the color and sizing Theme.
    this.typography = LegendTypography.applyStyles(
      base: typography,
      sizing: sizing.typographySizing,
      colors: colors.typography,
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
        systemNavigationBarColor: colors.bottomBar.backgroundColor,
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

  void changeSizingTheme() {
    updateTypography();
    notifyListeners();
  }

  /// Applies Sizing and Colors to the Typography
  void updateTypography() {
    typography = LegendTypography.applyStyles(
      sizing: sizing.typographySizing,
      colors: colors.typography,
      base: typography,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/restart.dart';
import 'colors/legend_color_theme.dart';
import 'colors/legend_palette.dart';
import 'colors/sub_palettes/app_bar_palette.dart';
import 'colors/sub_palettes/bottom_bar_palette.dart';
import 'colors/sub_palettes/footer_palette.dart';
import 'colors/sub_palettes/sider_palette.dart';
import 'sizing/legend_sizing.dart';
import 'sizing/legend_sizing_theme.dart';
import 'sizing/sub_sizing/sider_sizing.dart';

export '../typography/typography.dart';
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
  late LegendTypography typography;

  /// Color Theme for the whole applications. Contains a List of [LegendPalette]
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

  /// Sizing Theme for the whole applications. Contains a List of [LegendSizing] for multiple
  /// Screen Resolutions and platforms.
  final LegendSizingTheme sizingTheme;

  /// Gets the current [LegendSizing]
  LegendSizing get sizing => sizingTheme.sizing;

  FixedAppBarSizing get appBarSizing => sizing.appBarSizing;

  BottomBarSizing? get bottomBarSizing => sizing.bottomBarSizing;

  SiderSizing get siderSizing => sizing.siderSizing;

  List<double> get splits => sizingTheme.sizings.keys.toList();

  final bool _menuCollapsed = false;
  bool get menuCollapsed => _menuCollapsed;

  LegendTheme({
    required this.colorTheme,
    required this.sizingTheme,
    required LegendTypography typography,
  }) {
    this.typography = LegendTypography.applyStyles(
      sizing: sizing.typographySizing,
      colors: colors.typographyColors,
      typography: typography,
    );

    systemUIOverrides();
  }

  /// System UI Overrides. This is used to change the colors of the status bar and navigation bar
  void systemUIOverrides() {
    // If there is a bottom bar, set color to the background Color of the bottom bar
    // else use the first background color.
    Color _systemNavigationBarColor = sizing.showBottomBar
        ? bottomBarPalette.backgroundColor
        : colors.background[0];
    if (bottomBarSizing?.margin.bottom != 0) {
      _systemNavigationBarColor = colors.background[0];
    }
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/fixed_appbar_colors.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/fixed_appbar_sizing.dart';
import 'package:legend_design_core/layout/fixed/bottomBar.dart/fixed_bottom_bar.dart';
import 'package:legend_design_core/styles/theming/colors/legend_color_palette.dart';
import 'package:legend_design_core/styles/theming/colors/legend_color_theme.dart';
import 'package:legend_design_core/styles/theming/sizing/legend_sizing.dart';
import 'package:legend_design_core/styles/theming/sizing/legend_sizing_theme.dart';
import 'package:legend_design_core/typography/typography.dart';
import 'package:legend_design_core/utils/restart.dart';

class ThemeProvider extends ChangeNotifier {
  late LegendTypography typography;

  final LegendColorTheme colorTheme;
  final LegendSizingTheme sizingTheme;

  final bool _menuCollapsed = false;
  bool get menuCollapsed => _menuCollapsed;

  ThemeProvider({
    required this.colorTheme,
    required this.sizingTheme,
    required LegendTypography typography,
    LegendColorThemeType? themeType,
    LegendSizingType? sizingType,
  }) {
    this.typography = LegendTypography.applyStyles(
      sizing: sizing.typographySizing,
      colors: colors.typographyColors,
      typography: typography,
    );

    Color? _systemNavigationBarColor = bottomBarColors.backgroundColor;
    if (bottomBarSizing?.margin.bottom != 0) {
      _systemNavigationBarColor = colors.scaffoldBackgroundColor;
    }
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }

  void setSizing(int i) {
    sizingTheme.i = i;
    typography = LegendTypography.applyStyles(
      sizing: sizing.typographySizing,
      colors: colors.typographyColors,
      typography: typography,
    );
  }

  int getSizingIndex() {
    return sizingTheme.i;
  }

  LegendColorPalette get colors {
    int index = colorTheme.type.index;

    if (index < colorTheme.themes.length) {
      return colorTheme.themes[index];
    } else {
      return colorTheme.themes[0];
    }
  }

  // Getter Clean

  LegendSizing get sizing => sizingTheme.sizing;

  List<double> get splits => sizingTheme.splits;

  FixedAppBarColors get appBarColors => colors.appBarColors;

  FixedAppBarSizing get appBarSizing => sizing.appBarSizing;

  BottomBarSizing? get bottomBarSizing => sizing.bottomBarSizing;

  BottomBarColors get bottomBarColors => colors.bottomBarColors;

  void changeColorTheme(PaletteType type, BuildContext context) {
    colorTheme.setType(type);

    /* _appBarTheme = new LegendAppBarTheme(
      colors: colors,
      appBarType: FixedAppBarType.ICONS,
    );*/

    typography = LegendTypography.applyStyles(
      sizing: sizing.typographySizing,
      colors: colors.typographyColors,
      typography: typography,
    );
    notifyListeners();
    RestartWidget.restartApp(context);
  }
}

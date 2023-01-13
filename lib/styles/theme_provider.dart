import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_utils/legend_utils.dart';

class ThemeProvider extends ChangeNotifier {
  final LegendSizingTheme sizingTheme;
  final LegendColorTheme colorTheme;

  LegendTheme theme;

  ThemeProvider({
    required this.theme,
    required this.colorTheme,
    required this.sizingTheme,
  }) {
    systemUIOverrides();
  }

  /// Gets called every time the screen dimension change
  double changeSize(Size size) {
    final prev = sizingTheme.key;
    final next = sizingTheme.setWidth(size.width);

    if (prev != next) {
      Logger.log(
        'Sizing Theme changed from Key=$prev to Key=$next',
        'ThemeProvider',
      );
      theme = theme.copyWith(sizing: sizingTheme.sizing);
    }
    return next;
  }

  /// Changes the current [LegendPalette] responding to the [type]
  /// The LegendTypography will be updated accordingly.
  ///  and the App will restart.
  void changeColorTheme(PaletteType type) {
    colorTheme.type = type;
    theme = theme.copyWith(colors: colorTheme.current);
    systemUIOverrides();
    notifyListeners();
  }

  /// System UI Overrides. This is used to change the colors of the status bar and navigation bar
  void systemUIOverrides() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: theme.colors.bottomBar.backgroundColor,
      ),
    );
  }
}

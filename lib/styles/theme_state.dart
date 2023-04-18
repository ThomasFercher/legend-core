import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_utils/legend_utils.dart';

@immutable
class ThemeState {
  final LegendSizingTheme sizingTheme;
  final LegendColorTheme colorTheme;
  final LegendTheme theme;

  ThemeState({
    required this.theme,
    required this.colorTheme,
    required this.sizingTheme,
  }) {
    systemUIOverrides();
  }

  ThemeState copyWith({
    LegendTheme? theme,
  }) {
    return ThemeState(
      theme: theme ?? this.theme,
      colorTheme: colorTheme,
      sizingTheme: sizingTheme,
    );
  }

  // /// Gets called every time the screen dimension change
  // double changeSize(Size size) {
  //   final prev = sizingTheme.key;
  //   final next = sizingTheme.setWidth(size.width);

  //   if (prev != next) {
  //     Logger.log(
  //       'Sizing Theme changed from Key=$prev to Key=$next',
  //       'ThemeProvider',
  //     );
  //     theme = theme.copyWith(sizing: sizingTheme.sizing);
  //   }
  //   return next;
  // }

  // /// Changes the current [LegendPalette] responding to the [type]
  // /// The LegendTypography will be updated accordingly.
  // ///  and the App will restart.
  // void changeColorTheme(PaletteType type) {
  //   colorTheme.type = type;
  //   theme = theme.copyWith(colors: colorTheme.current);
  //  // systemUIOverrides();
  // }

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

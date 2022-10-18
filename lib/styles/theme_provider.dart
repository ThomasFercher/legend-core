import 'package:flutter/material.dart';
import 'package:legend_design_core/state/legend_state.dart';

class ThemeProvider extends ChangeNotifier {
  final LegendSizingTheme sizingTheme;
  final LegendColorTheme colorTheme;

  LegendTheme theme;

  ThemeProvider({
    required this.theme,
    required this.colorTheme,
    required this.sizingTheme,
  });

  void changeSize(Size size) {
    final sizing = sizingTheme.getSizing(size.width);
    theme = theme.copyWith(sizing: sizing);
    print(theme.sizing.key);
    //  notifyListeners();
  }

  void changeColorTheme(PaletteType type) {
    colorTheme.setType(type);
    final colors = colorTheme.current;
    theme = theme.copyWith(colors: colors);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/state/provider/legend_provider.dart';

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

  bool get isDark => colorTheme.type == PaletteType.dark();

  bool get isLight => colorTheme.type == PaletteType.light();

  bool isCustomTheme(String key) => colorTheme.type == PaletteType.custom(key);

  static void changeColorTheme(BuildContext context, PaletteType type) {
    ProviderWrapper.of<ThemeState>(context).update(
      (old) {
        old.colorTheme.type = type;
        return old.copyWith(
          theme: old.theme.copyWith(
            colors: old.colorTheme.current,
          ),
        );
      },
    );
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

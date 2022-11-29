import 'package:legend_design_core/styles/colors/legend_palette.dart';

const lightKey = 'light';
const darkKey = 'dark';

class LegendColorTheme {
  final LegendPalette light;
  final LegendPalette dark;
  final Map<String, LegendPalette>? custom;

  PaletteType _type;
  set type(PaletteType type) => _type = type;
  String get key => _type.key;

  LegendPalette get current {
    if (key == darkKey) return dark;
    if (key == lightKey) return light;
    if (custom == null) return light;
    return custom![key] ?? light; // TODO:System Default
  }

  LegendColorTheme({
    required PaletteType initalType,
    required this.light,
    required this.dark,
    this.custom,
  }) : _type = initalType;
}

class PaletteType {
  final String key;

  const PaletteType(this.key);

  factory PaletteType.dark() {
    return const PaletteType('dark');
  }

  factory PaletteType.light() {
    return const PaletteType('light');
  }
  factory PaletteType.custom(String key) {
    return PaletteType(key);
  }
}

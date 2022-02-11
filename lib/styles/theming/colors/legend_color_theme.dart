import 'package:legend_design_core/styles/theming/colors/legend_color_palette.dart';

class PaletteType {
  final int index;

  PaletteType(this.index);

  factory PaletteType.dark() {
    return PaletteType(1);
  }
  factory PaletteType.light() {
    return PaletteType(0);
  }
  factory PaletteType.custom({required int i}) {
    return PaletteType(i);
  }
}

class LegendColorTheme {
  final List<LegendColorPalette> themes;
  late PaletteType _type;

  void setType(PaletteType type) => _type = type;
  PaletteType get type => _type;

  LegendColorTheme({
    required this.themes,
  }) {
    _type = PaletteType.custom(i: 2);
  }
}

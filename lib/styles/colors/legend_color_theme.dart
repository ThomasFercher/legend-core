import 'package:legend_design_core/styles/colors/legend_palette.dart';

class LegendColorTheme {
  final PaletteType initalType;
  final List<LegendPalette> themes;
  late PaletteType _type;

  int get index => _type.index;

  void setType(PaletteType type) => _type = type;

  PaletteType get type => _type;

  LegendPalette get current {
    int i = index;
    if (i < themes.length) {
      return themes[i];
    } else {
      return themes[0];
    }
  }

  LegendColorTheme({
    this.initalType = const PaletteType(0),
    required this.themes,
  }) {
    _type = initalType;
  }
}

class PaletteType {
  final int index;

  const PaletteType(this.index);

  factory PaletteType.dark() {
    return const PaletteType(1);
  }
  factory PaletteType.light() {
    return const PaletteType(0);
  }
  factory PaletteType.custom({required int i}) {
    return PaletteType(i);
  }
}

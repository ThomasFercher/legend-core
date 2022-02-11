import 'package:legend_design_core/styles/theming/sizing/legend_sizing.dart';

class LegendSizingTheme {
  final List<LegendSizing> sizings;
  late final List<double> splits;
  int i = 0;

  LegendSizing get getSizing => sizings[i];

  LegendSizingTheme({
    required this.sizings,
    required List<double> splits,
  }) {
    splits.sort();
    this.splits = splits;

    print(splits);
  }

  LegendSizing get sizing {
    return sizings[i];
  }
}

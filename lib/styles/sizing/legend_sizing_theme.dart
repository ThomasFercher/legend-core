// ignore_for_file: prefer_initializing_formals

import 'package:legend_design_core/styles/sizing/legend_sizing.dart';

class LegendSizingTheme {
  final List<LegendSizing> sizings;
  late final List<double> splits;
  int index = 0;

  LegendSizingTheme({
    required this.sizings,
    required List<double> splits,
  }) {
    splits.sort();
    this.splits = splits;
  }

  LegendSizing get sizing => sizings[index];

  void setSizing(int i) => index = i;
}

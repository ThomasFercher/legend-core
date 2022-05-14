// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/sizing/legend_sizing.dart';

class LegendSizingTheme {
  final Map<double, LegendSizing> sizings;
  double _width = 0;
  double _key = 0;

  LegendSizingTheme({
    required this.sizings,
  });

  List<double> get splits => List.of(sizings.keys);

  /// Returns LegendSizing depending on the current Screen Width
  LegendSizing get sizing =>
      sizings.containsKey(_key) ? sizings[_key]! : sizings.values.first;

  double getNearestKey(double width) {
    List<double> splits = List.of(sizings.keys);

    for (var i = 0; i < splits.length; i++) {
      double split = splits[i];
      if (width <= split) {
        return split;
      }
    }

    // If the width is bigger than any key we return the last one
    // As the last key is supposed to be for the biggest Screen Width.
    return splits.last;
  }

  set setWidth(double width) {
    _width = width;
    _key = getNearestKey(_width);
  }

  double get key => _key;

  /// Returns true if the current [LegendSizing] key is the same as [width]
  bool sizeIs(double width) => _key == getNearestKey(width);

  /// Returns true if the current [LegendSizing] key is smaller than the
  /// specified [maxWidth]
  bool sizeIsMax(double maxWidth) => _key < getNearestKey(maxWidth);

  /// Returns true if the current [LegendSizing] key is bigger than the
  /// specified [minWidth]
  bool sizeIsMin(double minWidth) => _key > getNearestKey(minWidth);
}

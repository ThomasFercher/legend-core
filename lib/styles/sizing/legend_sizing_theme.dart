// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_design_core/styles/sizing/core/legend_sizing.dart';

import 'core/override.dart';

class LegendSizingTheme {
  late final List<LegendSizing>? sizings;
  final LegendSizing defaultSizing;
  final List<LegendSizingOverride>? overrides;

  double _width = 0;
  double skey = 0;

  LegendSizingTheme({
    required this.defaultSizing,
    this.overrides,
  }) {
    if (overrides == null) {
      sizings = null;
    } else {
      sizings = overrides!
          .map(
            (override) => LegendSizing.override(
              defaultSizing,
              override,
            ),
          )
          .toList();
    }
  }

  List<double> get splits {
    if (sizings == null || sizings!.isEmpty) {
      return [defaultSizing.key];
    }
    return sizings!.map((sizing) => sizing.key).toList();
  }

  /// Returns LegendSizing depending on the current Screen Width
  LegendSizing get sizing {
    if (sizings == null || sizings!.isEmpty) {
      return defaultSizing;
    } else if (PlatformInfo.isMobile) {
      return sizings!.first;
    } else {
      return sizings!.firstWhere(
        (element) => element.key == skey,
        orElse: () => defaultSizing,
      );
    }
  }

  double getNearestKey(double width) {
    if (sizings == null || sizings!.isEmpty) {
      return defaultSizing.key;
    }

    List<double> spl = splits;
    if (PlatformInfo.isMobile) {
      return spl.first;
    }

    for (var i = 0; i < spl.length; i++) {
      double split = spl[i];
      if (width <= split) {
        return split;
      }
    }

    // If the width is bigger than any key we return the last one
    // As the last key is supposed to be for the biggest Screen Width.
    return spl.last;
  }

  set setWidth(double width) {
    _width = width;
    skey = getNearestKey(_width);
  }

  double get key => skey;

  /// Returns true if the current [LegendSizing] key is the same as [width]
  bool sizeIs(double width) => skey == getNearestKey(width);

  /// Returns true if the current [LegendSizing] key is smaller than the
  /// specified [maxWidth]
  bool sizeIsMax(double maxWidth) => skey < getNearestKey(maxWidth);

  /// Returns true if the current [LegendSizing] key is bigger than the
  /// specified [minWidth]
  bool sizeIsMin(double minWidth) => skey > getNearestKey(minWidth);
}

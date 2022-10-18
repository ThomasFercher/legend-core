// ignore_for_file: prefer_initializing_formals

import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_design_core/styles/sizing/core/legend_sizing.dart';

import 'core/override.dart';

class LegendSizingTheme {
  final LegendSizing defaultSizing;
  late final List<LegendSizing> sizings;

  LegendSizingTheme({
    required this.defaultSizing,
    List<LegendSizingOverride>? overrides,
  }) {
    if (overrides == null) {
      sizings = [];
    } else {
      sizings = [
        for (LegendSizingOverride override in overrides)
          LegendSizing.override(
            defaultSizing,
            override,
          )
      ];
    }
  }

  /// Returns the Breaking Point of each [LegendSizing]
  List<double> get splits {
    return [
      if (sizings.isEmpty) defaultSizing.key,
      for (LegendSizing sizing in sizings) sizing.key
    ];
  }

  /// Returns LegendSizing depending on the current Screen Width
  LegendSizing getSizing(double width) {
    double _key = getNearestKey(width);
    if (sizings.isEmpty) {
      return defaultSizing;
    }
    if (PlatformInfo.isMobile) {
      return sizings.first;
    }
    return sizings.firstWhere(
      (sizing) => sizing.key == _key,
      orElse: () => defaultSizing,
    );
  }

  double getNearestKey(double width) {
    if (sizings.isEmpty) {
      return defaultSizing.key;
    }
    if (PlatformInfo.isMobile) {
      return splits.first;
    }
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

  /// Returns true if the current [LegendSizing] key is the same as [width]
  // bool sizeIs(double width) => _key == getNearestKey(width);

  /// Returns true if the current [LegendSizing] key is smaller than the
  /// specified [maxWidth]
  // bool sizeIsMax(double maxWidth) => _key < getNearestKey(maxWidth);

  /// Returns true if the current [LegendSizing] key is bigger than the
  /// specified [minWidth]
  // bool sizeIsMin(double minWidth) => _key > getNearestKey(minWidth);
}

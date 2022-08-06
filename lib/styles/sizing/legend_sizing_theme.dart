// ignore_for_file: prefer_initializing_formals

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_design_core/styles/sizing/core/legend_sizing.dart';

import 'core/override.dart';

class LegendSizingTheme {
  final LegendSizing defaultSizing;
  late final List<LegendSizing> sizings;

  /// This Stream is used so that LegendTheme knows when the [_key] has changed, so that it can
  /// update the Typography which is dependent on the current [sizing].
  final StreamController<SizingChangedEvent> sizingController =
      StreamController.broadcast();
  Stream<SizingChangedEvent> get sizingChanged => sizingController.stream;

  double _key = 0;
  double get key => _key;

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
  LegendSizing get sizing {
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

  set setWidth(double width) {
    double newKey = getNearestKey(width);
    if (newKey != _key) {
      var event = SizingChangedEvent(next: newKey, previous: _key);
      _key = newKey;
      sizingController.add(event);
    }
  }

  /// Returns true if the current [LegendSizing] key is the same as [width]
  bool sizeIs(double width) => _key == getNearestKey(width);

  /// Returns true if the current [LegendSizing] key is smaller than the
  /// specified [maxWidth]
  bool sizeIsMax(double maxWidth) => _key < getNearestKey(maxWidth);

  /// Returns true if the current [LegendSizing] key is bigger than the
  /// specified [minWidth]
  bool sizeIsMin(double minWidth) => _key > getNearestKey(minWidth);
}

@immutable
class SizingChangedEvent {
  final double previous;
  final double next;

  const SizingChangedEvent({
    required this.previous,
    required this.next,
  });
}

// ignore_for_file: comment_references

import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/styles/legend_theme.dart';

/// [SizeInfo] is a InheritedWidget which encapsulates Sizing data.
/// [SizeInfo] is the first Widget in the [LegendScaffold] tree.
/// This Widget will be rebuilt/initalized on every Resize of the App and pass down
/// variables which are dependendant on the Screen Size.
/// Just Like MediaQuery but with easier access to [width] and [height]
class SizeInfo extends InheritedWidget {
  final double width;
  final double height;
  final LegendSizingTheme sizing;

  SizeInfo({
    required this.width,
    required this.height,
    required this.sizing,
    required super.child,
  }) {
    sizing.setWidth = width;
  }

  static SizeInfo of(BuildContext context) {
    final SizeInfo? result =
        context.dependOnInheritedWidgetOfExactType<SizeInfo>();
    assert(result != null, 'No SizeInfo found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant SizeInfo oldWidget) {
    return oldWidget != this;
  }
}

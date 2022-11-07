// ignore_for_file: comment_references

import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/provider.dart';

import 'dart:ui';

import '../legend_app.dart';
import '../styles/theme_provider.dart';

/// [SizeInfo] is a InheritedWidget which encapsulates Sizing data.
/// [SizeInfo] is the first Widget in the [LegendScaffold] tree.
/// This Widget will be rebuilt/initalized on every Resize of the App and pass down
/// variables which are dependendant on the Screen Size.
/// Just Like MediaQuery but with easier access to [width] and [height]
class SizeInfo extends InheritedWidget {
  late final double pixelRatio;

  //Size in physical pixels
  late final Size physicalScreenSize;
  late final double physicalWidth;
  late final double physicalHeight;

//Size in logical pixels
  late final Size logicalScreenSize;
  late final double logicalWidth;
  late final double logicalHeight;

//Padding in physical pixels
  late final WindowPadding padding;

//Safe area paddings in logical pixels
  late final double paddingLeft;
  late final double paddingRight;
  late final double paddingTop;
  late final double paddingBottom;

//Safe area in logical pixels
  late final double safeWidth;
  late final double safeHeight;

  final BuildContext context;

  double get width => logicalWidth;
  double get height => logicalHeight;

  SizeInfo({
    required super.child,
    required this.context,
  }) {
    pixelRatio = window.devicePixelRatio;

    physicalScreenSize = window.physicalSize;
    physicalWidth = physicalScreenSize.width;
    physicalHeight = physicalScreenSize.height;

    logicalScreenSize = window.physicalSize / pixelRatio;
    logicalWidth = logicalScreenSize.width;
    logicalHeight = logicalScreenSize.height;
    padding = window.padding;

    paddingLeft = window.padding.left / window.devicePixelRatio;
    paddingRight = window.padding.right / window.devicePixelRatio;
    paddingTop = window.padding.top / window.devicePixelRatio;
    paddingBottom = window.padding.bottom / window.devicePixelRatio;

    safeWidth = logicalWidth - paddingLeft - paddingRight;
    safeHeight = logicalHeight - paddingTop - paddingBottom;

    context.read<ThemeProvider>().changeSize(Size(logicalWidth, logicalHeight));
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

import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/app_bar_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/bottom_bar_sizing.dart';
import 'package:legend_design_core/typography/typography.dart';

import 'sub_sizing/sider_sizing.dart';

export 'package:legend_design_core/styles/sizing/sub_sizing/app_bar_sizing.dart';
export 'package:legend_design_core/styles/sizing/sub_sizing/bottom_bar_sizing.dart';
export 'package:legend_design_core/typography/typography.dart';

class LegendSizing {
  final List<BorderRadius> borderRadius;
  final List<double> borderInset;
  final List<double> padding;
  final FixedAppBarSizing appBarSizing;
  final BottomBarSizing? bottomBarSizing;
  final LegendTypographySizing typographySizing;
  final SiderSizing siderSizing;
  final List<double> elevations;

  // Layout

  /// Whether to show the BottomBar
  final bool showBottomBar;

  /// Whether to show the Sider
  final bool hideSider;
  final bool collapsedSider;

  LegendSizing({
    required this.borderRadius,
    required this.borderInset,
    required this.padding,
    required this.appBarSizing,
    required this.typographySizing,
    required this.elevations,
    required this.siderSizing,
    this.collapsedSider = false,
    this.bottomBarSizing,
    this.hideSider = false,
    this.showBottomBar = false,
  });
}

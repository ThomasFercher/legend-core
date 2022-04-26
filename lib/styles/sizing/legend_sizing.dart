import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/app_bar_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/bottom_bar_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/menu_drawer_sizing.dart';
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

  final List<double> elevations;
  final List<double> iconSizes;

  // Layout

  /// Whether to show the BottomBar
  final bool showBottomBar;

  /// Whether to show the Sider
  final bool hideSider;
  final bool collapsedSider;

  /// Sub Sizing Themes
  late final SiderSizing siderSizing;
  late final MenuDrawerSizing menuDrawerSizing;

  LegendSizing({
    required this.borderRadius,
    required this.borderInset,
    required this.padding,
    required this.appBarSizing,
    required this.typographySizing,
    required this.elevations,
    this.collapsedSider = false,
    this.bottomBarSizing,
    this.hideSider = false,
    this.showBottomBar = false,
    required this.iconSizes,
    SiderSizing? siderSizing,
    MenuDrawerSizing? menuDrawerSizing,
  }) {
    this.siderSizing = SiderSizing.from(
      siderSizing: siderSizing,
      width: 200,
      iconSize: iconSizes[1],
      spacing: padding[1],
      itemHeight: 48,
      subMenuHeaderHeight: 48,
    );

    this.menuDrawerSizing = MenuDrawerSizing.from(
      sizing: menuDrawerSizing,
      width: 400,
      iconSize: 28,
      spacing: 12,
      itemHeight: 48,
      subMenuHeaderHeight: 48,
    );
  }
}

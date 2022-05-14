// ignore_for_file: comment_references

import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/app_bar_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/bottom_bar_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/menu_drawer_sizing.dart';

import '../typography/typography.dart';
import 'sub_sizing/sider_sizing.dart';

export 'package:legend_design_core/styles/sizing/sub_sizing/app_bar_sizing.dart';
export 'package:legend_design_core/styles/sizing/sub_sizing/bottom_bar_sizing.dart';

/// ## LegendSizing
/// A Object for storing Size Dependendant Styling and Sizing Variables.
/// There are Sub Sizing Objects for specific core components
///
/// ### Variables
/// * [padding] : **double**
/// * [elevations] :  **List\<double>**
/// * [borderRadius] :  **List\<double>**
/// * [borderInset] :  **List\<double>**
/// * [iconSizes] :  **List\<double>**
///
/// ### Sub Sizing
/// * [appBarSizing] for [LegendAppBar].
/// * [bottomBarSizing] for [LegendBottomBar].
/// * [typographySizing] for [LegendTypography].
/// * [siderSizing] for [LegendAppBar].
/// * [menuDrawerSizing] for [LegendAppBar].
class LegendSizing {
  ///
  /// Sub Sizing
  ///
  final AppBarSizing appBarSizing;
  late final BottomBarSizing bottomBarSizing;
  final TypographySizing typographySizing;
  late final SiderSizing siderSizing;
  late final MenuDrawerSizing menuDrawerSizing;

  ///
  /// Styling
  ///
  final List<double> elevations;
  final List<double> iconSizes;
  final List<BorderRadius> borderRadius;
  final List<double> borderInset;
  final List<double> padding;

  ///
  /// Layout
  ///

  /// Whether to show the BottomBar
  final bool showBottomBar;

  /// Whether to show the BottomBar If the platform is Mobile
  final bool? showBottomBarIfMobile;

  /// Whether to show the Sider
  final bool hideSider;
  final bool collapsedSider;

  /// Sub Sizing Themes

  LegendSizing({
    required this.borderRadius,
    required this.borderInset,
    required this.padding,
    required this.appBarSizing,
    required this.typographySizing,
    required this.elevations,
    this.collapsedSider = false,
    this.hideSider = false,
    this.showBottomBar = false,
    this.showBottomBarIfMobile,
    required this.iconSizes,
    SiderSizing? siderSizing,
    MenuDrawerSizing? menuDrawerSizing,
    BottomBarSizing? bottomBarSizing,
  }) {
    this.siderSizing = SiderSizing.from(
      horizontalPadding: 8,
      siderSizing: siderSizing,
      width: 200,
      iconSize: iconSizes[1],
      spacing: padding[1],
      itemHeight: 48,
      subMenuHeaderHeight: 48,
      itemPadding: EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 24,
      ),
      subItemPadding: EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 16,
      ),
    );

    this.bottomBarSizing = BottomBarSizing.from(
      fillBottom: true,
      sizing: bottomBarSizing,
      showText: true,
      textAtBottom: true,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(),
      height: 80,
      alignment: MainAxisAlignment.spaceEvenly,
      iconSize: 24,
      padding: EdgeInsets.zero,
      itemPadding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 4,
      ),
    );

    this.menuDrawerSizing = MenuDrawerSizing.from(
      sizing: menuDrawerSizing,
      width: 400,
      iconSize: 28,
      spacing: 12,
      itemHeight: 48,
      subMenuHeaderHeight: 48,
      subMenuIconSize: 22,
      itemPadding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      subItemPadding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
    );
  }
}

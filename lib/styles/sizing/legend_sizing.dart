// ignore_for_file: comment_references

import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/app_bar_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/bottom_bar_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/footer_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/menu_drawer_sizing.dart';

import '../typography/typography.dart';
import 'sub_sizing/sider_sizing.dart';

export 'package:legend_design_core/styles/sizing/sub_sizing/app_bar_sizing.dart';
export 'package:legend_design_core/styles/sizing/sub_sizing/bottom_bar_sizing.dart';

class LegendSizingOverride extends LegendSizingInfo {
  final SiderSizingOverride? sider;
  final AbbBarSizingOverride? appBar;
  final BottomBarSizingOverride? bottomBar;
  final MenuDrawerSizingOverride? menuDrawer;
  final FixedFooterSizingOverride? footer;

  LegendSizingOverride({
    required super.key,
    this.sider,
    this.appBar,
    this.bottomBar,
    this.footer,
    this.menuDrawer,
  }) : super(
          siderSizing: sider,
          appBarSizing: appBar,
          bottomBarSizing: bottomBar,
          menuDrawerSizing: menuDrawer,
          footerSizing: footer,
        );
}

abstract class LegendSizingInfo {
  final double key;

  ///
  /// Sub Sizing
  ///
  final AbbBarSizingInfo? appBarSizing;
  final BottomBarSizingInfo? bottomBarSizing;
  final SiderSizingInfo? siderSizing;
  final MenuDrawerSizingInfo? menuDrawerSizing;
  final FixedFooterSizingInfo? footerSizing;
  final TypographySizing? typographySizing;

  ///
  /// Styling
  ///
  final List<double>? elevations;
  final List<double>? iconSizes;
  final List<BorderRadius>? borderRadius;
  final List<double>? borderInset;
  final List<double>? padding;

  LegendSizingInfo({
    required this.key,
    this.appBarSizing,
    this.footerSizing,
    this.typographySizing,
    this.elevations,
    this.iconSizes,
    this.borderRadius,
    this.borderInset,
    this.bottomBarSizing,
    this.menuDrawerSizing,
    this.siderSizing,
    this.padding,
  });
}

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
class LegendSizing implements LegendSizingInfo {
  @override
  final double key;

  ///
  /// Sub Sizing
  ///
  @override
  final AppBarSizing appBarSizing;
  @override
  final BottomBarSizing bottomBarSizing;
  @override
  final TypographySizing typographySizing;
  @override
  final SiderSizing siderSizing;
  @override
  final MenuDrawerSizing menuDrawerSizing;

  @override
  final FixedFooterSizing footerSizing;

  ///
  /// Styling
  ///
  @override
  final List<double> elevations;
  @override
  final List<double> iconSizes;
  @override
  final List<BorderRadius> borderRadius;
  @override
  final List<double> borderInset;
  @override
  final List<double> padding;

  ///
  /// Layout
  ///

  /// Sub Sizing Themes

  LegendSizing({
    required this.key,
    required this.borderRadius,
    required this.borderInset,
    required this.footerSizing,
    required this.padding,
    required this.appBarSizing,
    required this.typographySizing,
    required this.elevations,
    required this.iconSizes,
    required this.bottomBarSizing,
    required this.siderSizing,
    required this.menuDrawerSizing,
  });

  factory LegendSizing.override(
      LegendSizing def, LegendSizingOverride override) {
    return LegendSizing(
      key: override.key,
      appBarSizing: AppBarSizing.override(
        def.appBarSizing,
        override.appBar,
      ),
      bottomBarSizing: BottomBarSizing.override(
        def.bottomBarSizing,
        override.bottomBar,
      ),
      typographySizing: override.typographySizing ?? def.typographySizing,
      siderSizing: SiderSizing.override(
        def: def.siderSizing,
        override: override.sider,
      ),
      menuDrawerSizing: MenuDrawerSizing.override(
        def.menuDrawerSizing,
        override.menuDrawer,
      ),
      footerSizing: FixedFooterSizing.override(
        def.footerSizing,
        override.footer,
      ),
      elevations: override.elevations ?? def.elevations,
      iconSizes: override.iconSizes ?? def.iconSizes,
      borderRadius: override.borderRadius ?? def.borderRadius,
      borderInset: override.borderInset ?? def.borderInset,
      padding: override.padding ?? def.padding,
    );
  }
}

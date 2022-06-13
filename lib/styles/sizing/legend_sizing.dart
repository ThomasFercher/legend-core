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
    super.custom,
    super.elevation1,
    super.elevation2,
    super.elevation3,
    super.elevation4,
    super.iconSize1,
    super.iconSize2,
    super.iconSize3,
    super.iconSize4,
    super.radius1,
    super.radius2,
    super.radius3,
    super.radius4,
    super.spacing1,
    super.spacing2,
    super.spacing3,
    super.spacing4,
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

  /// Elevation
  final double? elevation1;
  final double? elevation2;
  final double? elevation3;
  final double? elevation4;

  /// Icon Sizes
  final double? iconSize1;
  final double? iconSize2;
  final double? iconSize3;
  final double? iconSize4;

  /// Border Radius
  final double? radius1;
  final double? radius2;
  final double? radius3;
  final double? radius4;

  // Spacing
  final double? spacing1;
  final double? spacing2;
  final double? spacing3;
  final double? spacing4;

  final Map<String, double>? custom;

  const LegendSizingInfo({
    required this.key,
    this.custom,
    this.appBarSizing,
    this.bottomBarSizing,
    this.siderSizing,
    this.menuDrawerSizing,
    this.footerSizing,
    this.typographySizing,
    this.elevation1,
    this.elevation2,
    this.elevation3,
    this.elevation4,
    this.iconSize1,
    this.iconSize2,
    this.iconSize3,
    this.iconSize4,
    this.radius1,
    this.radius2,
    this.radius3,
    this.radius4,
    this.spacing1,
    this.spacing2,
    this.spacing3,
    this.spacing4,
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

  @override
  final double elevation1;
  @override
  final double elevation2;
  @override
  final double elevation3;
  @override
  final double elevation4;
  @override
  final double iconSize1;
  @override
  final double iconSize2;
  @override
  final double iconSize3;
  @override
  final double iconSize4;
  @override
  final double radius1;
  @override
  final double radius2;
  @override
  final double radius3;
  @override
  final double radius4;
  @override
  final double spacing1;
  @override
  final double spacing2;
  @override
  final double spacing3;
  @override
  final double spacing4;
  @override
  final Map<String, double>? custom;

  const LegendSizing({
    required this.key,
    required this.appBarSizing,
    required this.bottomBarSizing,
    required this.typographySizing,
    required this.siderSizing,
    required this.menuDrawerSizing,
    required this.footerSizing,
    required this.elevation1,
    required this.elevation2,
    required this.elevation3,
    required this.elevation4,
    required this.iconSize1,
    required this.iconSize2,
    required this.iconSize3,
    required this.iconSize4,
    required this.radius1,
    required this.radius2,
    required this.radius3,
    required this.radius4,
    required this.spacing1,
    required this.spacing2,
    required this.spacing3,
    required this.spacing4,
    this.custom,
  });

  factory LegendSizing.override(
    LegendSizing def,
    LegendSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return LegendSizing(
      key: override.key,
      typographySizing: override.typographySizing ?? def.typographySizing,
      appBarSizing: AppBarSizing.override(def.appBarSizing, override.appBar),
      bottomBarSizing:
          BottomBarSizing.override(def.bottomBarSizing, override.bottomBar),
      siderSizing: SiderSizing.override(def.siderSizing, override.sider),
      menuDrawerSizing:
          MenuDrawerSizing.override(def.menuDrawerSizing, override.menuDrawer),
      footerSizing:
          FixedFooterSizing.override(def.footerSizing, override.footer),
      elevation1: override.elevation1 ?? def.elevation1,
      elevation2: override.elevation2 ?? def.elevation2,
      elevation3: override.elevation3 ?? def.elevation3,
      elevation4: override.elevation4 ?? def.elevation4,
      iconSize1: override.iconSize1 ?? def.iconSize1,
      iconSize2: override.iconSize2 ?? def.iconSize2,
      iconSize3: override.iconSize3 ?? def.iconSize3,
      iconSize4: override.iconSize4 ?? def.iconSize4,
      radius1: override.radius1 ?? def.radius1,
      radius2: override.radius2 ?? def.radius2,
      radius3: override.radius3 ?? def.radius3,
      radius4: override.radius4 ?? def.radius4,
      spacing1: override.spacing1 ?? def.spacing1,
      spacing2: override.spacing2 ?? def.spacing2,
      spacing3: override.spacing3 ?? def.spacing3,
      spacing4: override.spacing4 ?? def.spacing4,
      custom: override.custom ?? def.custom,
    );
  }
}

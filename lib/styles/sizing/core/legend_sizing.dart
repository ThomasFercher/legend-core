// ignore_for_file: comment_references

import 'package:legend_design_core/styles/legend_theme.dart';

import '../../typography/style/typography_sizing.dart';
import '../sub_sizing/legend_sub_sizing.dart';
import 'core_sizing.dart';
import 'override.dart';

export 'package:legend_design_core/styles/sizing/sub_sizing/footer/footer_sizing.dart';
export 'package:legend_design_core/styles/sizing/sub_sizing/menuDrawer/menuDrawer_sizing.dart';
export '../../typography/typography.dart';
export '../sub_sizing/sider/sider_sizing.dart';
export 'package:legend_design_core/styles/sizing/sub_sizing/appbar/appbar_sizing.dart';
export 'package:legend_design_core/styles/sizing/sub_sizing/bottomBar/bottomBar_sizing.dart';

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
class LegendSizing implements LegendSubSizingInfo, LegendCoreSizing {
  @override
  final double key;

  ///
  /// Sub Sizing
  ///
  @override
  late final TypographySizing typographySizing;
  @override
  late final AppBarSizing appBarSizing;
  @override
  late final BottomBarSizing bottomBarSizing;
  @override
  late final SiderSizing siderSizing;
  @override
  late final MenuDrawerSizing menuDrawerSizing;
  @override
  late final FooterSizing footerSizing;

  final LegendSubSizing Function(LegendCoreSizing sizing) subSizing;

  ///
  /// Elevation
  ///
  @override
  final double elevation1;
  @override
  final double elevation2;
  @override
  final double elevation3;
  @override
  final double elevation4;

  ///
  /// IconSizes
  ///
  @override
  final double iconSize1;
  @override
  final double iconSize2;
  @override
  final double iconSize3;
  @override
  final double iconSize4;

  ///
  /// Radie
  ///
  @override
  final double radius1;
  @override
  final double radius2;
  @override
  final double radius3;
  @override
  final double radius4;

  ///
  /// Spacing / Padding
  ///
  @override
  final double spacing1;
  @override
  final double spacing2;
  @override
  final double spacing3;
  @override
  final double spacing4;

  /// Custom
  @override
  final Map<String, double> custom;

  LegendSizing({
    required this.key,
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
    required this.subSizing,
    this.custom = const {},
  }) {
    LegendSubSizing _subSizing = subSizing(this);
    appBarSizing = _subSizing.appBarSizing;
    typographySizing = _subSizing.typographySizing;
    bottomBarSizing = _subSizing.bottomBarSizing;
    footerSizing = _subSizing.footerSizing;
    menuDrawerSizing = _subSizing.menuDrawerSizing;
    siderSizing = _subSizing.siderSizing;
  }

  ///
  /// Returns a double from the [Map<String, double>]. If the key is not found 0 will be returned.
  /// Or if the [else] double is defined it will be returned.
  ///
  double get(String key, {double? notFound}) {
    if (custom.containsKey(key)) {
      return custom[key]!;
    } else {
      return notFound ?? 0;
    }
  }

  factory LegendSizing.override(
    LegendSizing def,
    LegendSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return LegendSizing(
      key: override.key,
      subSizing: (_) {
        return LegendSubSizing(
          typographySizing: TypographySizing.override(
            def.typographySizing,
            override.typographySizing,
          ),
          appBarSizing: AppBarSizing.override(
            def.appBarSizing,
            override.appBarSizing,
          ),
          bottomBarSizing: BottomBarSizing.override(
            def.bottomBarSizing,
            override.bottomBarSizing,
          ),
          siderSizing: SiderSizing.override(
            def.siderSizing,
            override.siderSizing,
          ),
          menuDrawerSizing: MenuDrawerSizing.override(
            def.menuDrawerSizing,
            override.menuDrawerSizing,
          ),
          footerSizing: FooterSizing.override(
            def.footerSizing,
            override.footerSizing,
          ),
        );
      },
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

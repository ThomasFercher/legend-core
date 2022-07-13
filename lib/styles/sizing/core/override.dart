import 'package:legend_design_core/styles/sizing/sub_sizing/legend_sub_sizing.dart';

import 'core_sizing.dart';
import 'legend_sizing.dart';

class LegendSizingOverride
    implements LegendCoreSizingNull, LegendSubSizingInfoNull {
  LegendSizingOverride({
    required this.key,
    this.subSizing,
    this.custom,
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
  }) {
    LegendSubSizingOverride? _subSizing = subSizing?.call(this);
    siderSizing = _subSizing?.siderSizing;
    appBarSizing = _subSizing?.appBarSizing;
    bottomBarSizing = _subSizing?.bottomBarSizing;
    footerSizing = _subSizing?.footerSizing;
    menuDrawerSizing = _subSizing?.menuDrawerSizing;
  }

  final LegendSubSizingOverride Function(LegendCoreSizingNull sizing)?
      subSizing;
  @override
  final double key;
  @override
  late final SiderSizingOverride? siderSizing;
  @override
  late final AppBarSizingOverride? appBarSizing;
  @override
  late final BottomBarSizingOverride? bottomBarSizing;
  @override
  late final MenuDrawerSizingOverride? menuDrawerSizing;
  @override
  late final FooterSizingOverride? footerSizing;
  // @override
//  late final TypographySizing? typographySizing;
  @override
  final double? elevation1;
  @override
  final double? elevation2;
  @override
  final double? elevation3;
  @override
  final double? elevation4;
  @override
  final double? iconSize1;
  @override
  final double? iconSize2;
  @override
  final double? iconSize3;
  @override
  final double? iconSize4;
  @override
  final double? radius1;
  @override
  final double? radius2;
  @override
  final double? radius3;
  @override
  final double? radius4;
  @override
  final double? spacing1;
  @override
  final double? spacing2;
  @override
  final double? spacing3;
  @override
  final double? spacing4;
  @override
  final Map<String, double>? custom;
}

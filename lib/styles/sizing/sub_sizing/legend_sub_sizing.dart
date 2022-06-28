import '../../typography/typography.dart';
import 'app_bar_sizing.dart';
import 'bottom_bar_sizing.dart';
import 'footer_sizing.dart';
import 'menu_drawer_sizing.dart';
import 'sider_sizing.dart';

abstract class LegendSubSizingInfo implements LegendSubSizingInfoNull {
  @override
  final AppBarSizing appBarSizing;
  @override
  final BottomBarSizing bottomBarSizing;
//  @override
  // final TypographySizing typographySizing;
  @override
  final SiderSizing siderSizing;
  @override
  final MenuDrawerSizing menuDrawerSizing;
  @override
  final FixedFooterSizing footerSizing;

  const LegendSubSizingInfo({
    required this.appBarSizing,
    required this.bottomBarSizing,
    //  required this.typographySizing,
    required this.siderSizing,
    required this.menuDrawerSizing,
    required this.footerSizing,
  });
}

abstract class LegendSubSizingInfoNull {
  final AbbBarSizingInfo? appBarSizing;
  final BottomBarSizingInfo? bottomBarSizing;
  // final Typrogra? typographySizing;
  final SiderSizingInfo? siderSizing;
  final MenuDrawerSizingInfo? menuDrawerSizing;
  final FixedFooterSizingInfo? footerSizing;

  const LegendSubSizingInfoNull({
    this.appBarSizing,
    this.bottomBarSizing,
    //  this.typographySizing,
    this.siderSizing,
    this.menuDrawerSizing,
    this.footerSizing,
  });
}

class LegendSubSizing extends LegendSubSizingInfo {
  const LegendSubSizing({
    required super.appBarSizing,
    required super.bottomBarSizing,
    required super.siderSizing,
    required super.menuDrawerSizing,
    required super.footerSizing,
    //  required super.typographySizing,
  });
}

class LegendSubSizingOverride implements LegendSubSizingInfoNull {
  @override
  final AbbBarSizingOverride? appBarSizing;
  @override
  final BottomBarSizingOverride? bottomBarSizing;
  // final Typrogra? typographySizing;
  @override
  final SiderSizingOverride? siderSizing;
  @override
  final MenuDrawerSizingOverride? menuDrawerSizing;
  @override
  final FixedFooterSizingOverride? footerSizing;

  const LegendSubSizingOverride({
    this.appBarSizing,
    this.bottomBarSizing,
    this.footerSizing,
    this.menuDrawerSizing,
    this.siderSizing,
  });
}

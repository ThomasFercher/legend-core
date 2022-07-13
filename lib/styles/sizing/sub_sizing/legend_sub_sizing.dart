import '../../typography/typography.dart';
import 'appbar/appBar_sizing.dart';
import 'bottomBar/bottomBar_sizing.dart';
import 'footer/footer_sizing.dart';
import 'menuDrawer/menuDrawer_sizing.dart';
import 'sider/sider_sizing.dart';

abstract class LegendSubSizingInfo implements LegendSubSizingInfoNull {
  @override
  final AppBarSizingStyle appBarSizing;
  @override
  final BottomBarSizingStyle bottomBarSizing;
//  @override
  // final TypographySizing typographySizing;
  @override
  final SiderSizingStyle siderSizing;
  @override
  final MenuDrawerSizingStyle menuDrawerSizing;
  @override
  final FooterSizingStyle footerSizing;

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
  final AppBarSizingInfoNull? appBarSizing;
  final BottomBarSizingInfoNull? bottomBarSizing;
  // final Typrogra? typographySizing;
  final SiderSizingInfoNull? siderSizing;
  final MenuDrawerSizingInfoNull? menuDrawerSizing;
  final FooterSizingInfoNull? footerSizing;

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
  final AppBarSizingOverride? appBarSizing;
  @override
  final BottomBarSizingOverride? bottomBarSizing;
  // final Typrogra? typographySizing;
  @override
  final SiderSizingOverride? siderSizing;
  @override
  final MenuDrawerSizingOverride? menuDrawerSizing;
  @override
  final FooterSizingOverride? footerSizing;

  const LegendSubSizingOverride({
    this.appBarSizing,
    this.bottomBarSizing,
    this.footerSizing,
    this.menuDrawerSizing,
    this.siderSizing,
  });
}

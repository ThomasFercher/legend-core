import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/layout/footer/footer_layout.dart';
import 'package:legend_design_core/layout/sider/sider_layout.dart';

import '../appBar.dart/appbar_layout.dart';
import '../bottomBar.dart/bottom_bar_layout.dart';
import '../menu_drawer/menu_drawer_layout.dart';

part 'route_layout.g.dart';

///
/// This Class defines the overall Layout of the App.
/// Both [LegendScaffold] and [LegendRouteBody], which are used to display the core of your app and pages, depend
/// on [RouteLayout] to layout. This class allows you to define a Layout for every possibility there is in Cross Platform Apps.
///
/// TODO: If default BottomBarLayout is not defined the Override should still be used
@LegendStyle()
abstract class RouteLayoutStyle {
  @LegendSubStyleField()
  final AppBarLayoutStyle appBarLayout;
  @LegendSubStyleField()
  final SiderLayoutStyle siderLayout;
  @LegendSubStyleField()
  final FooterLayoutStyle footerLayout;
  @LegendSubStyleField()
  final BottomBarLayoutStyle bottomBarLayout;
  @LegendSubStyleField()
  final MenuDrawerLayoutStyle menuDrawerLayout;

  // TODO: Implement Annotation for Fields which need override Methods on for buildMethod (current) and one for without build method

  RouteLayoutStyle({
    required this.appBarLayout,
    required this.siderLayout,
    required this.footerLayout,
    required this.bottomBarLayout,
    required this.menuDrawerLayout,
  });
}

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
@legendStyle
class RouteLayout {
  final AppBarLayoutStyle appBarLayout;
  final SiderLayout? siderLayout;
  final FooterLayout? footerLayout;
  final BottomBarLayout? bottomBarLayout;
  final MenuDrawerLayout? menuDrawerLayout;

  const RouteLayout({
    required this.appBarLayout,
    this.siderLayout,
    this.footerLayout,
    this.bottomBarLayout,
    this.menuDrawerLayout,
  });

  bool get appBarHasTabbar => appBarLayout.showTabbar == true;

  /* RouteLayout copyWith({
    AppBarLayout? appBarLayout,
    SiderLayout? siderLayout,
    FooterLayout? footerLayout,
    BottomBarLayout? bottomBarLayout,
    MenuDrawerLayout? menuDrawerLayout,
  }) =>
      RouteLayout(
        appBarLayout: this.appBarLayout?.copyWithInstance(appBarLayout),
        siderLayout: this.siderLayout?.copyWithInstance(siderLayout),
        footerLayout: this.footerLayout?.copyWithInstance(footerLayout),
        bottomBarLayout:
            this.bottomBarLayout?.copyWithInstance(bottomBarLayout),
        menuDrawerLayout:
            this.menuDrawerLayout?.copyWithInstance(menuDrawerLayout),
      );

  RouteLayout copyWithInstance(RouteLayout? instance) => RouteLayout(
        appBarLayout: appBarLayout?.copyWithInstance(instance?.appBarLayout),
        siderLayout: siderLayout?.copyWithInstance(instance?.siderLayout),
        footerLayout: footerLayout?.copyWithInstance(instance?.footerLayout),
        bottomBarLayout:
            bottomBarLayout?.copyWithInstance(instance?.bottomBarLayout),
        menuDrawerLayout:
            menuDrawerLayout?.copyWithInstance(instance?.menuDrawerLayout),
      );*/
}

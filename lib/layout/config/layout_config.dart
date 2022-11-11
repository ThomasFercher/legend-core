import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_layout.dart';
import 'package:legend_design_core/layout/config/appbar_layout.dart';

///
/// This Class defines the overall Layout of the App.
/// Both [LegendScaffold] and [LegendRouteBody], which are used to display the core of your app and pages, depend
/// on [RouteLayout] to layout. This class allows you to define a Layout for every possibility there is in Cross Platform Apps.
///
class RouteLayout {
  final AppBarLayout? appBarLayout;
  final SiderLayout? siderLayout;
  final FooterLayout? footerLayout;
  final BottomBarLayout? bottomBarLayout;

  const RouteLayout({
    this.appBarLayout,
    this.siderLayout,
    this.footerLayout,
    this.bottomBarLayout,
  });

  bool get appBarHasTabbar => appBarLayout?.showTabbar == true;
}

class DynamicRouteLayout {
  final Map<double, RouteLayout> layouts;

  RouteLayout getLayout(double split) {
    return layouts[split] ?? layouts.values.first;
  }

  factory DynamicRouteLayout.single(
    List<double> splits,
    RouteLayout layout,
  ) {
    Map<double, RouteLayout> l = {};

    for (double s in splits) {
      l[s] = layout;
    }

    return DynamicRouteLayout(l);
  }

  factory DynamicRouteLayout.firstExpand(
    List<double> splits,
    List<RouteLayout> layouts,
  ) {
    Map<double, RouteLayout> l = {};
    RouteLayout lay = layouts.first;
    for (var i = 0; i < splits.length; i++) {
      double split = splits[i];
      if (layouts.length > i) lay = layouts[i];

      l[split] = lay;
    }

    return DynamicRouteLayout(l);
  }

  factory DynamicRouteLayout.expandAfter(
    List<double> splits,
    List<RouteLayout> layouts,
    int j,
  ) {
    Map<double, RouteLayout> l = {};
    RouteLayout lay = layouts.first;
    double split = splits[0];
    l[split] = lay;
    for (var i = 1; i < splits.length; i++) {
      split = splits[i];

      if (i <= j) {
        l[split] = lay;
      }

      if (layouts.length > i) {
        lay = layouts[i];
      }
      if (i > j) {
        l[split] = lay;
      }
    }

    return DynamicRouteLayout(l);
  }

  DynamicRouteLayout(this.layouts);
}

enum SiderLayout {
  Left,
  Right,
  None,
}

enum FooterLayout {
  // Fixed ?
  Show,
  None,
}

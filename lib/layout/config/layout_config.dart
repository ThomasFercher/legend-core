///
/// This Class defines the overall Layout of the App.
/// Both [LegendScaffold] and [LegendRouteBody], which are used to display the core of your app and pages, depend
/// on [RouteLayout] to layout. This class allows you to define a Layout for every possibility there is in Cross Platform Apps.
///
class RouteLayout {
  final AppbarLayout appBarLayout;
  final SiderLayout siderLayout;
  final FooterLayout footerLayout;
  final BottomBarLayout bottomBarLayout;

  const RouteLayout({
    this.appBarLayout = AppbarLayout.None,
    this.siderLayout = SiderLayout.None,
    this.footerLayout = FooterLayout.None,
    this.bottomBarLayout = BottomBarLayout.None,
  });
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

  DynamicRouteLayout(this.layouts);
}

enum AppbarLayout {
  FixedAbove,
  FixedWithin,
  LooseWithin,
  PinnedWithin,
  None,
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

enum BottomBarLayout {
  Show,
  None,
}

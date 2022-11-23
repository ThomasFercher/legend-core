import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/navigation/tabbar/legend_tabbar.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';

class ScaffoldTabbar extends LegendWidget {
  const ScaffoldTabbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    RouteInfo? route = LegendRouter.of(context).routerDelegate.current;

    assert(route != null, 'No Route found found in context');

    var routes = [route!];

    if (route.children != null && route.children!.isNotEmpty) {
      routes.addAll(route.children!);
    } else {
      RouteInfo? parent = RouteInfoProvider.getParentRouteInfo(context, route);
      if (parent != null) {
        routes = [parent];
        if (parent.children != null) routes.addAll(parent.children!);
      }
    }
    final height = theme.appBarSizing.tabbarSizing?.height ?? 56;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height),
      child: LegendTabBar(
        routes: routes,
      ),
    );
  }
}

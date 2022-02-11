import 'package:flutter/material.dart';
import 'package:legend_design_core/router/routeInfoProvider.dart';

import '../objects/menu_option.dart';
import 'delegate.dart';
import 'errorpages/notfound.dart';
import 'routes/route_info.dart';
import 'routes/section_provider.dart';

class RouterProvider extends InheritedWidget {
  final WebRouterDelegate routerDelegate;
  @override
  final Widget child;
  final List<RouteInfo> routes;
  final List<MenuOption> menuOptions;

  RouterProvider({
    Key? key,
    required this.routerDelegate,
    required this.child,
    required this.routes,
    required this.menuOptions,
  }) : super(key: key, child: child);

  static RouterProvider of(BuildContext context) {
    final RouterProvider? result =
        context.dependOnInheritedWidgetOfExactType<RouterProvider>();
    assert(result != null, 'No RouterProvider found in context');
    return result!;
  }

  void pushPage({required RouteSettings settings}) {
    Page p = createPage(settings, getRouteWidget(settings, routes));
    routerDelegate.pushPage(p);
  }

  static RouteInfo getRouteWidget(RouteSettings s, List<RouteInfo> routes) {
    if (routes.isEmpty) {
      return RouteInfo(name: 'Not Found', page: NotFoundPage());
    }

    for (final RouteInfo routeinfo in routes) {
      if (routeinfo.name == s.name) {
        return routeinfo;
      } else if (routeinfo.children != null) {
        for (final RouteInfo r in routeinfo.children!) {
          if (r.name == s.name) {
            return r;
          }
        }
      }
    }

    return RouteInfo(name: '/notfound', page: NotFoundPage());
  }

  static Page createPage(RouteSettings s, RouteInfo route) {
    String now = DateTime.now().millisecondsSinceEpoch.toString();

    return MaterialPage(
      key: ValueKey(s.name! + now),
      name: s.name,
      arguments: s.arguments,
      child: Material(
        child: SectionProvider(
          sections: route.sections,
          child: RouteInfoProvider(
            route: s,
            child: route.page,
          ),
        ),
      ),
    );
  }

  @override
  bool updateShouldNotify(covariant RouterProvider old) =>
      routerDelegate.currentConfiguration !=
      old.routerDelegate.currentConfiguration;
}

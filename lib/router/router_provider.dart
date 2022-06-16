import 'package:flutter/cupertino.dart';
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
  BuildContext? context;

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
    result!.context = context;
    return result;
  }

  void pushPage({required RouteSettings settings}) {
    RouteInfo info = getRouteWidget(settings, routes);

    if (info is ModalRouteInfo) {
      Navigator.of(context!).pushNamed(settings.name ?? '/');
    } else {
      Page<dynamic> p = createPage(settings, info);
      routerDelegate.pushPage(p);
    }
  }

  static Widget? _getModalBody(RouteSettings s, List<RouteInfo> routes) {
    if (routes.isEmpty) {
      return null;
    }

    for (final RouteInfo info in routes) {
      if (info.name == s.name) {}
    }

    return Container();
  }

  static RouteInfo getRouteWidget(RouteSettings s, List<RouteInfo> routes) {
    if (routes.isEmpty) {
      return PageRouteInfo(name: 'Not Found', page: NotFoundPage());
    }

    for (final RouteInfo routeinfo in routes) {
      if (routeinfo.name == s.name) {
        return routeinfo;
      }
      if (routeinfo is PageRouteInfo) {
        if (routeinfo.children != null) {
          for (final RouteInfo r in routeinfo.children!) {
            if (r.name == s.name) {
              return r;
            }
          }
        }
      }
      if (routeinfo is SectionRouteInfo) {
        if (routeinfo.children != null) {
          for (final RouteInfo r in routeinfo.children!) {
            if (r.name == s.name) {
              return r;
            }
          }
        }
      }
    }

    return PageRouteInfo(name: '/notfound', page: NotFoundPage());
  }

  static Page<dynamic> createPage(
    RouteSettings s,
    RouteInfo info,
  ) {
    if (info is PageRouteInfo) {
      return createPageRoute(s, info);
    } else if (info is SectionRouteInfo) {
      return createSectionPage(s, info);
    } else {
      return createSimplePage(s, info);
    }
  }

  static Page<dynamic> createSimplePage(RouteSettings s, RouteInfo route) {
    String now = DateTime.now().millisecondsSinceEpoch.toString();

    return MaterialPage(
      key: ValueKey(s.name! + now),
      name: s.name,
      arguments: s.arguments,
      child: Material(
        child: RouteInfoProvider(
          route: s,
          child: route.page,
        ),
      ),
    );
  }

  static Page<dynamic> createPageRoute(RouteSettings s, PageRouteInfo route) {
    String now = DateTime.now().millisecondsSinceEpoch.toString();

    return MaterialPage(
      key: ValueKey(s.name! + now),
      name: s.name,
      arguments: s.arguments,
      child: Material(
        child: RouteInfoProvider(
          route: s,
          child: route.page,
        ),
      ),
    );
  }

  static Page<dynamic> createSectionPage(
    RouteSettings s,
    SectionRouteInfo route,
  ) {
    String now = DateTime.now().millisecondsSinceEpoch.toString();
    route.sections;
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
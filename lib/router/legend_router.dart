import 'package:flutter/material.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import '../layout/fixed/menu/tiles/menu_option.dart';
import 'legendPage.dart';
import 'router_delegate.dart';
import 'routes/route_info.dart';
export '../layout/fixed/menu/tiles/menu_option.dart';
export 'errorpages/notfound.dart';
export 'router_delegate.dart';
export 'routes/route_info.dart';

const PageRouteInfo notFound = PageRouteInfo(
  child: SizedBox(),
  info: ScaffoldRouteInfo(
      layoutType: LayoutType.FixedHeader, pageName: 'Not Found'),
  name: '',
);

// ignore: must_be_immutable
class LegendRouter extends InheritedWidget {
  final LegendRouterDelegate routerDelegate;
  @override
  final Widget child;
  final List<RouteInfo> routes;
  late final List<PageRouteInfo> pageRoutes;
  late final List<ModalRouteInfo> modalRoutes;
  final List<MenuOption> menuOptions;
  BuildContext? context;

  LegendRouter({
    Key? key,
    required this.routerDelegate,
    required this.child,
    required this.routes,
    required this.menuOptions,
  }) : super(key: key, child: child) {
    modalRoutes = routes.whereType<ModalRouteInfo>().toList();
    pageRoutes = routes.whereType<PageRouteInfo>().toList();
  }

  static LegendRouter of(BuildContext context) {
    final LegendRouter? result =
        context.dependOnInheritedWidgetOfExactType<LegendRouter>();
    assert(result != null, 'No RouterProvider found in context');
    result!.context = context;
    return result;
  }

  void pushPage({required RouteSettings settings, bool useKey = false}) {
    RouteInfo info = getRouteWidget(settings, routes);

    Page<dynamic> p = createPage(settings, info);

    if (useKey) {
      routerDelegate.navigatorKey?.currentState?.pushNamed(p.name ?? '');
    } else {
      routerDelegate.pushPage(p);
    }
  }

  MenuOption? searchCurrent(List<MenuOption> options, String name) {
    for (MenuOption option in options) {
      if (option.page == name) return option;
      if (option.children != null) {
        return searchCurrent(option.children!, name);
      }
    }
  }

  MenuOption getCurrent() {
    String name = routerDelegate.current.name;

    MenuOption option = searchCurrent(menuOptions, name)!;
    return option;
  }

  /// Should only be used to push Dialogs that are outside of the content or are overallaping AppBar or Sider
  void pushGlobalModal({required RouteSettings settings, bool useKey = false}) {
    RouteInfo info = getRouteWidget(settings, routes);

    if (info is ModalRouteInfo) {
      Page<dynamic> p = createPage(settings, info);

      Navigator.of(context!).pushNamed(info.name);
    }
  }

  void popPage({bool useKey = false}) {
    if (useKey) {
      routerDelegate.navigatorKey?.currentState?.pop();
    } else {
      routerDelegate.popRoute();
    }
  }

  void popModal() {
    Navigator.of(context!).pop();
  }

  static RouteInfo getRouteWidget(RouteSettings s, List<RouteInfo> routes) {
    if (routes.isEmpty) {
      return notFound;
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
    }

    return notFound;
  }

  static Page<dynamic> createPage(
    RouteSettings s,
    RouteInfo info,
  ) {
    if (info is PageRouteInfo) {
      return createPageRoute(s, info);
    } else {
      return createSimplePage(s, info);
    }
  }

  static Page<dynamic> createSimplePage(RouteSettings s, RouteInfo route) {
    return LegendModalPage(
      child: Stack(
        children: [
          RouteInfoProvider(
            child: route.child,
            route: s,
          ),
        ],
      ),
      name: route.name,
      arguments: route.arguments,
      key: UniqueKey(),
    );
  }

  static LegendPage createPageRoute(RouteSettings s, PageRouteInfo route) {
    return LegendPage(
      child: RouteInfoProvider(
        child: route.child,
        route: s,
      ),
      name: route.name,
      arguments: route.arguments,
      key: UniqueKey(),
    );
  }

  @override
  bool updateShouldNotify(covariant LegendRouter old) =>
      routerDelegate.currentConfiguration !=
      old.routerDelegate.currentConfiguration;
}

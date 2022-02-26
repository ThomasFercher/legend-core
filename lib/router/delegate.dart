import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/router/routes/popup_route/legend_popup_route.dart';
import 'package:legend_design_core/router/routes/popup_route/popup_route_config.dart';

import 'router_provider.dart';
import 'routes/route_info.dart';

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class WebRouterDelegate extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  final List<Page> _pages = [];
  List<RouteInfo> _routes = [];

  @override
  Widget build(BuildContext context) {
    _routes = RouterProvider.of(context).routes;

    if (_pages.isEmpty) {
      _pages.insert(
        0,
        RouterProvider.createPage(
          RouteSettings(name: '/'),
          RouterProvider.getRouteWidget(RouteSettings(name: '/'), _routes),
        ),
      );
    }

    return Navigator(
      pages: List.of(_pages),
      key: navigatorKey,
      observers: [routeObserver],
      onPopPage: _onPopPage,
      onGenerateRoute: onGenerateRoute,
    );
  }

  Route<dynamic>? onGenerateRoute(RouteSettings s) {
    RouteInfo info = RouterProvider.getRouteWidget(s, _routes);

    if (info is ModalRouteInfo) {
      return LegendPopupRoute(
          settings: s,
          widget: info.page,
          config: PopupRouteConfig(aligment: Alignment.centerRight));
    }
    return null;
  }

  @override
  List<Page> get currentConfiguration => List.of(_pages);

  @override
  Future<bool> popRoute() {
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;
    popRoute();
    return true;
  }

  void pushPage(Page page) {
    if (_pages.last.key == page.key) {
      _pages[_pages.length - 1] = page;
    } else {
      _pages.add(page);
    }

    notifyListeners();
  }

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) {
    List<Page> pages = [];
    for (final RouteSettings s in configuration) {
      pages.add(
        RouterProvider.createPage(
          s,
          RouterProvider.getRouteWidget(s, _routes),
        ),
      );
    }

    _setPath(pages);
    return Future.value(null);
  }

  void _setPath(List<Page> pages) {
    _pages.clear();
    _pages.addAll(pages);
    if (_pages.first.name != '/') {
      _pages.insert(
        0,
        RouterProvider.createPage(
          RouteSettings(name: '/'),
          RouterProvider.getRouteWidget(RouteSettings(name: '/'), _routes),
        ),
      );
    }
    notifyListeners();
  }
}

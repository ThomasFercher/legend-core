import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_frame.dart';

import 'legend_router.dart';
import 'routes/popup_route/legend_popup_route.dart';
import 'routes/popup_route/popup_route_config.dart';

class LegendRouterDelegate extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  final List<Page<dynamic>> _pages = [];

  late List<PageRouteInfo> _pageRoutes;
  late List<RouteInfo> _routes;
  late PageRouteInfo current;

  PageRouteInfo? getCurrentPageRoute(Page<dynamic> page) {
    PageRouteInfo? pageRoute;
    for (PageRouteInfo info in _pageRoutes) {
      if (info.name == page.name) return info;
      if (info.children != null && info.children!.isNotEmpty) {
        List<PageRouteInfo> pr =
            List.of(info.children!.whereType<PageRouteInfo>().toList());
        for (PageRouteInfo a in pr) {
          if (a.name == page.name) return a;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _routes = LegendRouter.of(context).routes;
    _pageRoutes = List.of(_routes.whereType<PageRouteInfo>().toList());

    if (_pages.isEmpty) {
      _pages.insert(
        0,
        LegendRouter.createPage(
          RouteSettings(name: '/'),
          LegendRouter.getRouteWidget(RouteSettings(name: '/'), _routes),
        ),
      );
    }

    current = getCurrentPageRoute(_pages.last) ?? notFound;

    return ScaffoldFrame(
      page: current,
      child: Navigator(
        pages: List.of(_pages),
        key: navigatorKey,
        onPopPage: _onPopPage,
        observers: [
          HeroController(),
        ],
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }

  Route<dynamic>? onGenerateRoute(RouteSettings s) {
    RouteInfo info = LegendRouter.getRouteWidget(s, _routes);

    if (info is ModalRouteInfo) {
      return LegendPopupRoute(
        settings: s,
        widget: info.child,
        config: PopupRouteConfig(
          aligment: Alignment.centerRight,
        ),
      );
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
    print("object");
    List<Page> pages = [];
    for (final RouteSettings s in configuration) {
      pages.add(
        LegendRouter.createPage(
          s,
          LegendRouter.getRouteWidget(s, _routes),
        ),
      );
    }

    _setPath(pages);
    print("object");
    return Future.value(null);
  }

  void _setPath(List<Page> pages) {
    _pages.clear();
    _pages.addAll(pages);
    if (_pages.first.name != '/') {
      _pages.insert(
        0,
        LegendRouter.createPage(
          RouteSettings(name: '/'),
          LegendRouter.getRouteWidget(RouteSettings(name: '/'), _routes),
        ),
      );
    }
    notifyListeners();
  }
}

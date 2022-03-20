import 'package:flutter/widgets.dart';
import 'package:legend_design_core/objects/menu_option.dart';
import 'package:legend_design_core/router/router_provider.dart';

class RouteInfoProvider extends InheritedWidget {
  final RouteSettings route;

  RouteInfoProvider({
    Key? key,
    required Widget child,
    required this.route,
  }) : super(key: key, child: child);

  static RouteInfoProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RouteInfoProvider>();
  }

  @override
  bool updateShouldNotify(RouteInfoProvider oldWidget) {
    return oldWidget.route != route;
  }

  static MenuOption? getCurrentMenuOption(BuildContext context) {
    RouteSettings? route = RouteInfoProvider.of(context)?.route;
    List<MenuOption> options = RouterProvider.of(context).menuOptions;

    for (final MenuOption op in options) {
      if (op.page == route?.name) {
        return op;
      }
      if (op.children != null) {
        for (final MenuOption sub in op.children!) {
          if (sub.page == route?.name) {
            return sub;
          }
        }
      }
    }

    return null;
  }

  static MenuOption? getParentMenuOption(BuildContext context) {
    RouteSettings? route = RouteInfoProvider.of(context)?.route;
    List<MenuOption> options = RouterProvider.of(context).menuOptions;

    if (route == null || route.name == null) {
      return null;
    }

    for (final MenuOption op in options) {
      if (route.name!.contains(op.page)) {
        var slash = 0;
        var s = op.page;
        if (s == '/' || s.isEmpty) {
          continue;
        }

        for (final c in s.characters) {
          if (c == '/') {
            slash++;
          }
        }

        var rS = route.name!;
        var slashR = 0;
        for (final c in rS.characters) {
          if (c == '/') {
            slashR++;
          }
        }

        if (slashR > slash) {
          return op;
        }
      }
    }

    return null;
  }
}

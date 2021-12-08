import 'package:flutter/widgets.dart';
import 'package:legend_design_core/objects/menu_option.dart';
import 'package:legend_design_core/router/router_provider.dart';

class RouteInfoProvider extends InheritedWidget {
  final RouteSettings route;

  RouteInfoProvider({
    Key? key,
    required this.child,
    required this.route,
  }) : super(key: key, child: child);

  final Widget child;

  static RouteInfoProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RouteInfoProvider>();
  }

  @override
  bool updateShouldNotify(RouteInfoProvider oldWidget) {
    return oldWidget.route != route;
  }
}

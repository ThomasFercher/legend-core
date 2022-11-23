import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/widgets/metric_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_router/legend_router.dart';

class ModalNavigator extends LegendWidget {
  final Widget Function(String initalRoute) buildHome;

  const ModalNavigator({
    super.key,
    required this.buildHome,
  });

  Route<dynamic>? _modalGeneration(
    RouteSettings s,
    Iterable<RouteInfo> routes,
    BuildContext context,
    LegendTheme theme,
  ) {
    RouteInfo info = LegendRouter.getRouteWidget(s, routes);
    if (info is ModalRouteInfo) {
      return GlobalModal.modalRouteBuilder(
        s,
        context,
        (context) => info.page,
      );
    }

    return null;
  }

  String get initalRoute =>
      WidgetsBinding.instance.platformDispatcher.defaultRouteName;

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final routes = LegendRouter.of(context).routes;
    final modalNavKey = GlobalKey<NavigatorState>();

    return Navigator(
      key: modalNavKey,
      onGenerateRoute: (r) {
        return _modalGeneration(r, routes, context, theme);
      },
      initialRoute: initalRoute,
      onGenerateInitialRoutes: (state, initialRoute) {
        print('Inital Route: $initialRoute');

        final modalRouteSetting = RouteSettings(name: initialRoute);
        final info = LegendRouter.getRouteWidget(modalRouteSetting, routes);
        final isModal = info is ModalRouteInfo;
        final route = isModal ? '/' : initialRoute;

        return [
          CupertinoPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (BuildContext context) {
              return ModalRouter(
                navigatorKey: modalNavKey,
                child: buildHome(route),
              );
            },
          ),
        ];
      },
    );
  }
}

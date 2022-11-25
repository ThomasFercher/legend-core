import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_router/legend_router.dart';

class ModalNavigator extends LegendWidget {
  final Widget home;

  const ModalNavigator({
    super.key,
    required this.home,
  });

  Route<dynamic>? _modalGeneration(
    RouteSettings s,
    Iterable<RouteInfo> routes,
    BuildContext context,
    LegendTheme theme,
  ) {
    final info = LegendRouter.getRouteWidget(s, routes);
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
        return [
          CupertinoPageRoute(
            builder: (BuildContext context) {
              return ModalRouter(
                navigatorKey: modalNavKey,
                child: home,
              );
            },
          ),
        ];
      },
    );
  }
}

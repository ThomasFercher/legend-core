import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/state/provider/legend_provider.dart';
import 'package:legend_design_core/styles/theme_state.dart';
import 'package:legend_router/legend_router.dart';

final modalNavKey = GlobalKey<NavigatorState>();

class ModalNavigator extends StatelessWidget {
  final Widget home;
  final List<RouteInfo> routes;

  const ModalNavigator({
    super.key,
    required this.home,
    required this.routes,
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
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
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

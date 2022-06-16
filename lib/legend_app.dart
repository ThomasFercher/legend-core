import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:legend_design_core/interfaces/route_inferface.dart';
import 'package:legend_design_core/interfaces/theme_interface.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_frame.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/sizing/size_info.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/modals/global_modal.dart';
import 'package:legend_router/router/route_info_parser.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'data/asset_loader.dart';
import 'layout/bottomBar.dart/bottom_bar_provider.dart';

const List<LocalizationsDelegate<dynamic>> localizations = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

class LegendNavigatorFrame extends NavigatorFrame {
  @override
  Widget buildFrame(
    BuildContext context,
    Navigator navigator,
    RouteInfo? current,
    RouteDisplay? display,
  ) {
    if (current is LegendRouteInfo) {
      return ScaffoldFrame(
        page: current,
        child: navigator,
        display: display,
      );
    } else {
      return navigator;
    }
  }
}

class LegendApp extends StatelessWidget {
  // Interface containing Methos related to Routing
  final RouteInterface<dynamic> routesDelegate;

  final ThemeInterface themeDelegate;

  final Widget? logo;
  final String title;

  late final LegendTheme theme;

  final Future<Object?>? future;
  final Widget Function(BuildContext context, LegendTheme theme)?
      buildSplashscreen;

  final List<SingleChildWidget>? providers;

  late final List<RouteDisplay> routeDisplays = routesDelegate.buildDisplays();

  LegendApp({
    Key? key,
    required this.routesDelegate,
    required this.themeDelegate,
    required this.title,
    this.logo,
    this.future,
    this.buildSplashscreen,
    this.providers,
  }) : super(key: key) {
    theme = LegendTheme(
      colorTheme: themeDelegate.buildColorTheme(),
      sizingTheme: themeDelegate.buildSizingTheme(),
      typography: themeDelegate.buildTypography(),
      buildConfig: themeDelegate.buildConfig.call(),
    );
  }

  Future<bool> _init(BuildContext context) async {
    // Await User defined Futrure
    if (future != null) {
      await future;
    }

    // Prechache Asset Images
    await AssetLoader.prechacheAssets(context);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    // Router Delegate
    final routerDelegate = LegendRouterDelegate(
      frame: LegendNavigatorFrame(),
      displays: routeDisplays,
    );

    Map<dynamic, DynamicRouteLayout> routeLayouts =
        routesDelegate.buildLayouts(theme);

    // TODO: CleanUp
    List<SingleChildWidget> _providers = [
      ChangeNotifierProvider<LegendTheme>(
        create: (_) => theme,
      ),
      ChangeNotifierProvider<BottomBarProvider>(
        create: (_) => BottomBarProvider(
          first: 0,
          options: routeDisplays,
        ),
      ),
    ];
    if (providers != null) _providers.addAll(providers!);

    return Localizations(
      delegates: localizations,
      locale: Locale('en', 'US'),
      child: MultiProvider(
        providers: _providers,
        child: RestartWidget(
          child: Builder(builder: (context) {
            List<RouteInfo> routes =
                routesDelegate.buildRoutes(routeLayouts, theme).ex();

            return LegendRouter(
              routerDelegate: routerDelegate,
              routes: routes,
              routeDisplays: routeDisplays,
              child: WidgetsApp(
                color: theme.colors.primary,
                debugShowCheckedModeBanner: false,
                pageRouteBuilder: GlobalModal.pageRouteBuilder,
                onGenerateRoute: (settings) {
                  RouteInfo info =
                      LegendRouter.getRouteWidget(settings, routes);
                  if (info is ModalRouteInfo) {
                    return GlobalModal.modalRouteBuilder(
                      settings,
                      context,
                      (context) => SizeInfo(
                        child: info.page,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        sizing: theme.sizingTheme,
                      ),
                    );
                  }
                },
                home: FutureBuilder(
                  future: _init(context),
                  builder: (context, snapshot) {
                    LegendTheme theme = Provider.of<LegendTheme>(context);

                    if (snapshot.connectionState == ConnectionState.done ||
                        buildSplashscreen == null) {
                      return LayoutProvider(
                        title: title,
                        logo: logo,
                        child: WidgetsApp.router(
                          localizationsDelegates: [
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          locale: Locale('en', 'US'),
                          title: title,
                          debugShowCheckedModeBanner: false,
                          routerDelegate: routerDelegate,
                          routeInformationParser:
                              LegendRouteInformationParser(),
                          backButtonDispatcher: RootBackButtonDispatcher(),
                          color: theme.colors.primary,
                          useInheritedMediaQuery: true,
                        ),
                      );
                    } else {
                      return buildSplashscreen!(context, theme);
                    }
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

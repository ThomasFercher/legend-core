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
import 'package:legend_router/router/route_info_parser.dart';
import 'package:legend_router/router/route_info_provider.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'layout/bottomBar.dart/bottom_bar_provider.dart';

class LegendNavigatorFrame extends NavigatorFrame {
  @override
  Widget buildFrame(
      BuildContext context, Navigator navigator, RouteInfo? current) {
    if (current is ScaffoldRouteInfo) {
      return ScaffoldFrame(page: current, child: navigator);
    } else {
      return navigator;
    }
  }
}

class LegendApp extends StatelessWidget {
  // Router Delegate
  final routerDelegate = LegendRouterDelegate(frame: LegendNavigatorFrame());

  // Interface containing Methos related to Routing
  final RouteInterface<dynamic> routesDelegate;

  final ThemeInterface themeDelegate;

  final Widget? logo;
  final String? title;

  late final LegendTheme theme;

  final Future<Object?>? future;
  final Widget Function(BuildContext context, LegendTheme theme)?
      buildSplashscreen;

  final List<SingleChildWidget>? providers;

  LegendApp({
    Key? key,
    required this.routesDelegate,
    required this.themeDelegate,
    this.logo,
    this.future,
    this.buildSplashscreen,
    this.title,
    this.providers,
  }) : super(key: key) {
    theme = LegendTheme(
      colorTheme: themeDelegate.buildColorTheme(),
      sizingTheme: themeDelegate.buildSizingTheme(),
      typography: themeDelegate.buildTypography(),
      buildConfig: themeDelegate.buildConfig.call(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<RouteDisplay> routeDisplays = routesDelegate.buildDisplays();
    Map<dynamic, DynamicRouteLayout> routeLayouts =
        routesDelegate.buildLayouts(theme);

    // TODO: CleanUp
    List<SingleChildWidget> _providers = [
      ChangeNotifierProvider<LegendTheme>(
        create: (_) => theme,
      ),
      ChangeNotifierProvider<BottomBarProvider>(
        create: (_) => BottomBarProvider(routeDisplays.first),
      ),
    ];
    if (providers != null) _providers.addAll(providers!);

    return Localizations(
      delegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('en', 'US'),
      child: Builder(builder: (context) {
        List<RouteInfo> routes =
            routesDelegate.buildRoutes(routeLayouts, theme);
        return MultiProvider(
          providers: _providers,
          child: LegendRouter(
            routerDelegate: routerDelegate,
            routes: routes,
            routeDisplays: routeDisplays,
            child: WidgetsApp(
              color: theme.colors.primary,
              debugShowCheckedModeBanner: false,
              pageRouteBuilder: <T>(
                RouteSettings settings,
                Widget Function(BuildContext) builder,
              ) {
                return CupertinoPageRoute<T>(
                  settings: settings,
                  builder: builder,
                );
              },
              onGenerateRoute: (routesettings) {
                RouteInfo info =
                    LegendRouter.getRouteWidget(routesettings, routes);
                if (info is ModalRouteInfo) {
                  return CupertinoDialogRoute(
                    barrierDismissible: true,
                    settings: routesettings,
                    transitionDuration: Duration(
                      milliseconds: 400,
                    ),

                    transitionBuilder: (context, _, __, child) {
                      CurvedAnimation animation = CurvedAnimation(
                        parent: _,
                        curve: Curves.easeInOutCirc,
                      );
                      Tween<AlignmentGeometry> aligment = Tween(
                        begin: Alignment(8, 0),
                        end: Alignment(1, 0),
                      );
                      return AlignTransition(
                        alignment: aligment.animate(animation),
                        child: child,
                      );
                    },
                    //   useSafeArea: false,
                    builder: (context) => RouteInfoProvider(
                      route: routesettings,
                      child: SizeInfo(
                        sizing: theme.sizingTheme,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: info.page,
                      ),
                    ),
                    context: context,
                  );
                }
              },
              home: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  LegendTheme theme = Provider.of<LegendTheme>(context);
                  if ((snapshot.hasData || buildSplashscreen == null) ||
                      buildSplashscreen == null) {
                    return LayoutProvider(
                      title: title,
                      logo: logo,
                      child: RestartWidget(
                        child: WidgetsApp.router(
                          localizationsDelegates: [
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          locale: Locale('en', 'US'),
                          title: 'Legend Design',
                          debugShowCheckedModeBanner: false,
                          routerDelegate: routerDelegate,
                          routeInformationParser:
                              LegendRouteInformationParser(),
                          backButtonDispatcher: RootBackButtonDispatcher(),
                          color: theme.colors.primary,
                        ),
                      ),
                    );
                  } else {
                    return buildSplashscreen!(context, theme);
                  }
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}

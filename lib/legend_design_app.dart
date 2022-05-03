import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:legend_design_core/layout/fixed/bottomBar.dart/bottom_bar_provider.dart';
import 'package:legend_design_core/layout/fixed/footer/fixed_footer.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/router/legendPage.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_design_core/styles/sizing/size_info.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'router/route_info_parser.dart';
import 'styles/colors/legend_colors.dart';
import 'utils/restart.dart';

class LegendApp extends StatelessWidget {
  final routerDelegate = LegendRouterDelegate();
  final List<MenuOption> menuOptions;
  final List<RouteInfo> routes;
  final List<RouteInfo>? globalRoutes;

  final Widget? logo;
  final LegendTheme theme;
  final FixedFooter? globalFooter;
  final String? title;
  final Future<Object?>? future;
  final Widget? splashScreen;
  final List<SingleChildWidget>? providers;

  LegendApp({
    Key? key,
    required this.menuOptions,
    required this.routes,
    this.globalRoutes,
    this.logo,
    required this.theme,
    this.future,
    this.globalFooter,
    this.splashScreen,
    this.title,
    this.providers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SingleChildWidget> _providers = [
      ChangeNotifierProvider<LegendTheme>(
        create: (_) => theme,
      ),
      ChangeNotifierProvider<BottomBarProvider>(
        create: (_) => BottomBarProvider(menuOptions.first),
      ),
    ];
    if (providers != null) _providers.addAll(providers!);

    return MultiProvider(
      providers: _providers,
      child: LegendRouter(
        routerDelegate: routerDelegate,
        routes: routes,
        menuOptions: menuOptions,
        child: WidgetsApp(
          debugShowCheckedModeBanner: false,
          pageRouteBuilder: <T>(
            RouteSettings settings,
            Widget Function(BuildContext) builder,
          ) {
            return CupertinoPageRoute<T>(settings: settings, builder: builder);
          },
          onGenerateRoute: (routesettings) {
            RouteInfo info = LegendRouter.getRouteWidget(routesettings, routes);
            return MaterialPageRoute(
              builder: (context) => SizeInfo(
                sizing: theme.sizingTheme,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: info.child,
              ),
            );
          },
          home: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              LegendTheme theme = Provider.of<LegendTheme>(context);
              if (snapshot.hasData || splashScreen == null) {
                return LayoutProvider(
                  globalFooter: globalFooter,
                  title: title,
                  logo: logo,
                  child: RestartWidget(
                    child: WidgetsApp.router(
                      title: 'Legend Design',
                      locale: Locale("en"),
                      localizationsDelegates: [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      debugShowCheckedModeBanner: false,
                      routerDelegate: routerDelegate,
                      routeInformationParser: LegendRouteInformationParser(),
                      backButtonDispatcher: RootBackButtonDispatcher(),
                      color: theme.colors.primary,
                    ),
                  ),
                );
              } else {
                return Material(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      child: splashScreen,
                    ),
                  ),
                );
              }
            },
          ),
          color: theme.colors.primary,
        ),
      ),
    );
  }
}

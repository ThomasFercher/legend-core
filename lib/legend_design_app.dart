import 'package:animations/animations.dart';
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

  final List<RouteInfo> Function(LegendTheme theme) buildRoutes;

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
    required this.buildRoutes,
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

    return Localizations(
      delegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('en', 'US'),
      child: Builder(builder: (context) {
        List<RouteInfo> routes = buildRoutes(theme);
        return MultiProvider(
          providers: _providers,
          child: LegendRouter(
            routerDelegate: routerDelegate,
            routes: routes,
            menuOptions: menuOptions,
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
                    builder: (context) => SizeInfo(
                      sizing: theme.sizingTheme,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: info.child,
                    ),
                    context: context,
                  );
                }
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
            ),
          ),
        );
      }),
    );
  }
}

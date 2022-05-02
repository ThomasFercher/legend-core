import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/layout/fixed/bottomBar.dart/bottom_bar_provider.dart';
import 'package:legend_design_core/layout/fixed/footer/fixed_footer.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'router/route_info_parser.dart';
import 'styles/colors/legend_colors.dart';
import 'utils/restart.dart';

class LegendApp extends StatelessWidget {
  final routerDelegate = LegendRouterDelegate();
  final List<MenuOption> menuOptions;
  final List<RouteInfo> routes;
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

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData || splashScreen == null) {
          return MultiProvider(
            providers: _providers,
            child: Builder(
              builder: (context) {
                LegendTheme theme = Provider.of<LegendTheme>(context);
                return LayoutProvider(
                  globalFooter: globalFooter,
                  title: title,
                  logo: logo,
                  child: LegendRouter(
                    routerDelegate: routerDelegate,
                    routes: routes,
                    menuOptions: menuOptions,
                    child: RestartWidget(
                      child: MaterialApp.router(
                        title: 'Legend Design',
                        debugShowCheckedModeBanner: false,
                        themeMode: ThemeMode.light,
                        routerDelegate: routerDelegate,
                        routeInformationParser: LegendRouteInformationParser(),
                        backButtonDispatcher: RootBackButtonDispatcher(),
                        theme: ThemeData(
                          useMaterial3: true,
                          colorScheme: ColorScheme(
                            primary: theme.colors.primary,
                            secondary: theme.colors.primary,
                            surface: theme.colors.foreground[1],
                            background: Colors.transparent,
                            error: Colors.redAccent,
                            onPrimary: LegendColors.gray3,
                            onSecondary: LegendColors.gray9,
                            onSurface: theme.colors.foreground[3],
                            onBackground: theme.colors.foreground[1],
                            onError: LegendColors.gray3,
                            brightness: Brightness.light,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
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
    );
  }
}

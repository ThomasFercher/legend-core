import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/fixed_footer.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/router/router_provider.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'layout/fixed/bottomBar.dart/bottom_bar_provider.dart';
import 'objects/menu_option.dart';
import 'router/delegate.dart';
import 'router/parser.dart';
import 'router/routes/route_info.dart';
import 'styles/theming/colors/legend_colors.dart';
import 'utils/restart.dart';

class LegendApp extends StatelessWidget {
  final routerDelegate = WebRouterDelegate();
  final List<MenuOption> menuOptions;
  final List<RouteInfo> routes;
  final Widget? logo;
  final ThemeProvider theme;
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
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => theme,
      ),
      ChangeNotifierProvider<BottomBarProvider>(
        create: (_) => BottomBarProvider(
          menuOptions.first,
        ),
      ),
    ];
    if (providers != null) _providers.addAll(providers!);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData || splashScreen == null) {
          return MultiProvider(
            providers: _providers,
            child: Builder(builder: (context) {
              ThemeProvider theme = Provider.of<ThemeProvider>(context);
              return LayoutProvider(
                globalFooter: globalFooter,
                title: title,
                logo: logo,
                child: RouterProvider(
                  routerDelegate: routerDelegate,
                  routes: routes,
                  menuOptions: menuOptions,
                  child: RestartWidget(
                    child: MaterialApp.router(
                      title: 'Legend Design',
                      routerDelegate: routerDelegate,
                      routeInformationParser: const MyRouteInformationParser(),
                      debugShowCheckedModeBanner: false,
                      backButtonDispatcher: RootBackButtonDispatcher(),
                      themeMode: ThemeMode.light,
                      theme: ThemeData(
                        // Implement as method of LegendTheme
                        colorScheme: ColorScheme(
                          primary: theme.colors.primaryColor,
                          secondary: theme.colors.secondaryColor,
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
            }),
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
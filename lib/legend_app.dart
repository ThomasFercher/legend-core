import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:legend_design_core/interfaces/route_inferface.dart';
import 'package:legend_design_core/interfaces/theme_interface.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_provider.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/router/modal_navigator.dart';
import 'package:legend_design_core/router/navigator_frame.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/theme_provider.dart';
import 'package:legend_design_core/widgets/metric_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_router/legend_router.dart';
import 'package:provider/provider.dart';
import 'data/asset_loader.dart';
import 'layout/bottomBar.dart/bottom_bar_provider.dart';

const List<LocalizationsDelegate<dynamic>> localizations = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

class LegendApp extends StatelessWidget {
  // Interface containing Methos related to Routing
  final RouteInterface<dynamic> routesDelegate;

  // Interface containing Methods related to Colors and Sizing
  final ThemeInterface themeDelegate;

  final Widget Function(BuildContext context)? logoBuilder;
  final String title;

  /// Until this [future] completes, the app will show a Splascreen.
  final Future<Object?>? future;

  /// If [future] is not null this method will build the Splasscreen while the [future] is not finished.
  final Widget Function(BuildContext context, LegendTheme theme)?
      buildSplashscreen;

  const LegendApp({
    Key? key,
    required this.routesDelegate,
    required this.themeDelegate,
    required this.title,
    this.logoBuilder,
    this.future,
    this.buildSplashscreen,
  });

  ///
  /// Do things before any page is built.
  ///
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
    // Theme Delegates
    final sizingTheme = themeDelegate.buildSizingTheme();
    final colorTheme = themeDelegate.buildColorTheme();
    final _theme = LegendTheme(
      scaffoldConfig: routesDelegate.buildConfig(),
      typography: themeDelegate.buildTypography(),
      sizing: sizingTheme.sizing,
      colors: colorTheme.current,
      splits: sizingTheme.splits,
    );
    final routeLayouts = routesDelegate.buildLayouts(sizingTheme.splits);
    final routes = routesDelegate.buildRoutes(routeLayouts).expandedChildren;
    final bottombarRoutes =
        routes.whereType<PageRouteInfo>().where((r) => r.depth == 1).toList();

    // Router Delegate
    final routerDelegate =
        LegendRouterDelegate(frame: LegendNavigatorFrame(), routes: routes);

    return Localizations(
      delegates: localizations,
      locale: Locale('en', 'US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(
              theme: _theme,
              colorTheme: colorTheme,
              sizingTheme: sizingTheme,
            ),
          ),
          ChangeNotifierProvider<BottomBarProvider>(
            create: (_) => BottomBarProvider(
              routes: bottombarRoutes,
            ),
          ),
          ChangeNotifierProvider<AppBarProvider>(
            create: (_) => AppBarProvider(),
          ),
        ],
        child: FutureBuilder(
          future: _init(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              if (buildSplashscreen != null) {
                final theme = LegendTheme.of(context);
                return buildSplashscreen!(context, theme);
              }
              return Container();
            }

            return LegendRouter(
              routerDelegate: routerDelegate,
              routes: routes,
              child: LayoutProvider(
                title: title,
                logoBuilder: logoBuilder,
                child: MetricReactor(
                  child: ModalNavigator(
                    home: Router(
                      routerDelegate: routerDelegate,
                      routeInformationParser: LegendRouteInformationParser(),
                      routeInformationProvider:
                          PlatformRouteInformationProvider(
                        initialRouteInformation: RouteInformation(
                          location: WidgetsBinding
                              .instance.platformDispatcher.defaultRouteName,
                        ),
                      ),
                      backButtonDispatcher: RootBackButtonDispatcher(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:legend_design_core/interfaces/legend_config.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_provider.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/router/modal_navigator.dart';
import 'package:legend_design_core/router/navigator_frame.dart';
import 'package:legend_design_core/state/provider/legend_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/theme_state.dart';
import 'package:legend_design_core/widgets/metric_state.dart';
import 'data/asset_loader.dart';
import 'layout/bottomBar.dart/bottom_bar_provider.dart';

const List<LocalizationsDelegate<dynamic>> localizations = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

final navKey = GlobalKey<NavigatorState>();

class LegendApp extends StatefulWidget {
  final LegendConfig config;
  final Widget Function(BuildContext context)? logoBuilder;
  final String title;

  /// Until this [future] completes, the app will show a Splascreen.
  final Future<Object?>? future;

  /// If [future] is not null this method will build the Splasscreen while the [future] is not finished.
  final Widget Function(BuildContext context, LegendTheme theme)?
      buildSplashscreen;

  LegendApp({
    super.key,
    required this.config,
    required this.title,
    this.logoBuilder,
    this.future,
    this.buildSplashscreen,
  });

  @override
  State<LegendApp> createState() => _LegendAppState();
}

class _LegendAppState extends State<LegendApp> {
  late final LegendRouterDelegate _routerDelegate;

  LegendConfig get config => widget.config;

  @override
  void initState() {
    _routerDelegate = LegendRouterDelegate(
      frame: LegendNavigatorFrame(),
      routes: config.routes,
      navigatorKey: navKey,
      onGenerateRoute: config.routesDelegate.onGenerateRoute,
      hideRoutes: (c) => config.routesDelegate.hideRoutes(c, context),
    );
    Future.microtask(() async {
      await _init(context);
      setState(() {});
    });
    super.initState();
  }

  ///
  /// Do things before any page is built.
  ///
  Future<bool> _init(BuildContext context) async {
    // Await User defined Futrure
    // if (widget.future != null) {
    //   await widget.future;
    // }

    // Prechache Asset Images
    await AssetLoader.prechacheAssets(context);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    // Config
    final _theme = LegendTheme(
      scaffoldConfig: config.scaffoldConfig,
      typography: config.typography,
      sizing: config.sizingTheme.sizing,
      colors: config.colorTheme.current,
      splits: config.sizingTheme.splits,
    );

    final routes = config.routes;
    final bottombarRoutes =
        routes.whereType<PageRouteInfo>().where((r) => r.depth == 1).toList();

    return ProviderWrapper<BottomBarState>(
      builder: () => BottomBarState(
        routes: bottombarRoutes,
      ),
      child: ProviderWrapper<AppBarProvider>(
        builder: () => AppBarProvider(),
        child: ProviderWrapper<ThemeState>(
          builder: () => ThemeState(
            theme: _theme,
            colorTheme: config.colorTheme,
            sizingTheme: config.sizingTheme,
          ),
          child: Localizations(
            delegates: localizations,
            locale: Locale('en', 'US'),
            child: LegendRouter(
              routerDelegate: _routerDelegate,
              routes: routes,
              child: LayoutProvider(
                title: widget.title,
                logoBuilder: widget.logoBuilder,
                child: MetricReactor(
                  child: ModalNavigator(
                    routes: routes,
                    home: Router(
                      routerDelegate: _routerDelegate,
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
            ),
          ),
        ),
      ),
    );
  }
}

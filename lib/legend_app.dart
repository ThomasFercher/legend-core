import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:legend_design_core/interfaces/route_inferface.dart';
import 'package:legend_design_core/interfaces/theme_interface.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_frame.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/theme_provider.dart';

import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/modal_router.dart';
import 'package:legend_router/router/modals/global_modal.dart';
import 'package:legend_router/router/route_info_parser.dart';

import 'package:legend_utils/legend_utils.dart';
import 'package:provider/provider.dart';

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
  ) {
    if (current is LegendRouteInfo) {
      return ScaffoldFrame(
        page: current,
        child: navigator,
      );
    } else {
      return navigator;
    }
  }
}

class LegendApp extends StatelessWidget {
  // Interface containing Methos related to Routing
  final RouteInterface<dynamic> routesDelegate;

  // Interface containing Methods related to Colors and Sizing
  final ThemeInterface themeDelegate;

  final Widget? logo;
  final String title;

  /// Until this [future] completes, the app will show a Splascreen.
  final Future<Object?>? future;

  /// If [future] is not null this method will build the Splasscreen while the [future] is not finished.
  final Widget Function(BuildContext context, LegendTheme theme)?
      buildSplashscreen;

//  late final LegendTheme theme;
//  late final List<RouteDisplay> routeDisplays = routesDelegate.buildDisplays();

  const LegendApp({
    Key? key,
    required this.routesDelegate,
    required this.themeDelegate,
    required this.title,
    this.logo,
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

  Route<dynamic>? _modalGeneration(
    RouteSettings s,
    Iterable<RouteInfo> routes,
    BuildContext context,
    LegendTheme theme,
  ) {
    RouteInfo info = LegendRouter.getRouteWidget(s, routes);
    if (info is ModalRouteInfo) {
      return GlobalModal.modalRouteBuilder(
        s,
        context,
        (context) => SizeInfo(
          child: info.page,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          context: context,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Router Delegate
    final LegendRouterDelegate routerDelegate = LegendRouterDelegate(
      frame: LegendNavigatorFrame(),
    );

    final GlobalKey<NavigatorState> modalNavKey = GlobalKey();

    final LegendSizingTheme theme = themeDelegate.buildSizingTheme();

    final LegendTheme inital = LegendTheme(
      scaffoldConfig: routesDelegate.buildConfig(),
      typography: themeDelegate.buildTypography(),
      sizing: theme.getSizing(0),
      colors: themeDelegate.buildColorTheme().current,
      splits: theme.splits,
    );
    final Map<dynamic, DynamicRouteLayout> routeLayouts =
        routesDelegate.buildLayouts(inital);
    final List<RouteInfo> routes =
        routesDelegate.buildRoutes(routeLayouts, inital).ex();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            theme: inital,
            colorTheme: themeDelegate.buildColorTheme(),
            sizingTheme: theme,
          ),
        ),
        ChangeNotifierProvider<BottomBarProvider>(
          create: (_) => BottomBarProvider(
            first: 0,
            options: routes,
          ),
        ),
      ],
      child: LayoutProvider(
        title: title,
        logo: logo,
        child: Localizations(
          delegates: localizations,
          locale: Locale('en', 'US'),
          child: Consumer(builder: (context, ref, _) {
            LegendTheme theme = LegendTheme.of(context);
            /*   final Map<dynamic, DynamicRouteLayout> routeLayouts =
                routesDelegate.buildLayouts(theme);
            final List<RouteInfo> routes =
                routesDelegate.buildRoutes(routeLayouts, theme).ex();*/

            return LegendRouter(
              routerDelegate: routerDelegate,
              routes: routes,
              child: WidgetsApp(
                color: theme.colors.primary,
                debugShowCheckedModeBanner: false,
                pageRouteBuilder: GlobalModal.pageRouteBuilder,
                onGenerateRoute: (r) =>
                    _modalGeneration(r, routes, context, theme),
                navigatorKey: modalNavKey,
                home: ModalRouter(
                  navigatorKey: modalNavKey,
                  child: FutureBuilder(
                    future: _init(context),
                    builder: (context, snapshot) {
                      LegendTheme theme = LegendTheme.of(context);

                      if (snapshot.connectionState == ConnectionState.done ||
                          buildSplashscreen == null) {
                        return WidgetsApp.router(
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
        ),
      ),
    );
  }
}

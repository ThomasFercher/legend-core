import 'package:legend_design_core/interfaces/color_delegate.dart';
import 'package:legend_design_core/interfaces/layout_delegate.dart';
import 'package:legend_design_core/interfaces/size_delegate.dart';
import 'package:legend_design_core/interfaces/typography_delegate.dart';
import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';

import 'route_delegate.dart';

class LegendConfig {
  final ColorsDelegate colorsDelegate;
  final SizingDelegate sizingDelegate;
  final TypographyDelegate typographyDelegate;
  final LayoutDelegate layoutDelegate;
  final RoutesDelegate routesDelegate;

  final PaletteType initalColors;

  late final LegendSizingTheme sizingTheme = LegendSizingTheme(
    defaultSizing: sizingDelegate.defaultSizing,
    overrides: sizingDelegate.overrides,
  );
  late final LegendColorTheme colorTheme = LegendColorTheme(
    dark: colorsDelegate.darkTheme,
    light: colorsDelegate.lightTheme,
    custom: colorsDelegate.customThemes,
    initalType: initalColors,
  );

  late final ScaffoldConfig scaffoldConfig = layoutDelegate.defaultConfig;
  late final LegendTypography typography = typographyDelegate.typography;
  late final List<RouteInfo> routes = routesDelegate.buildRoutes(routeLayouts);
  late final Map<String, DynamicRouteLayout> routeLayouts =
      layoutDelegate.buildLayouts(sizingTheme.splits);

  LegendConfig({
    required this.colorsDelegate,
    required this.sizingDelegate,
    required this.typographyDelegate,
    required this.layoutDelegate,
    required this.routesDelegate,
    required this.initalColors,
  });
}

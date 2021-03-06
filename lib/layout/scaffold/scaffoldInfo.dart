import 'package:flutter/cupertino.dart';
import 'package:http/retry.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:provider/provider.dart';

class ScaffoldInfo extends InheritedWidget {
  final LegendScaffold scaffold;
  final RouteInfo routeInfo;
  final RouteDisplay? display;

  ScaffoldInfo({
    Key? key,
    required Widget child,
    required this.scaffold,
    required this.display,
    required this.routeInfo,
  }) : super(key: key, child: child);

  static ScaffoldInfo of(BuildContext context) {
    final ScaffoldInfo? result =
        context.dependOnInheritedWidgetOfExactType<ScaffoldInfo>();
    assert(result != null, 'No ScaffoldInfo found in context');
    return result!;
  }

  RouteLayout getLayout(LegendTheme theme) {
    return scaffold.layout.getLayout(theme.sizingTheme.key);
  }

  static ScaffoldBuilders getBuilders(BuildContext context) {
    return ScaffoldInfo.of(context).scaffold.builders;
  }

  static ScaffoldWhether whether(BuildContext context) {
    return ScaffoldInfo.of(context).scaffold.whether;
  }

  bool showFooter(BuildContext context) {
    FooterLayout layout = scaffold.layout
        .getLayout(context.watch<LegendTheme>().sizingTheme.key)
        .footerLayout;

    return layout == FooterLayout.Show;
  }

  ScaffoldConfig get getConfig => ScaffoldConfig(
        builders: scaffold.builders,
        whether: scaffold.whether,
        layout: scaffold.layout,
      );

  @override
  bool updateShouldNotify(ScaffoldInfo old) {
    return old != this;
  }
}

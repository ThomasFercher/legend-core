import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/config/route_layout.dart';
import 'package:legend_design_core/layout/footer/footer_layout.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_router/legend_router.dart';

class ScaffoldInfo extends InheritedWidget {
  final LegendScaffold scaffold;
  final RouteInfo routeInfo;
  final RouteLayout routeLayout;
  final bool showHeader;

  ScaffoldInfo({
    Key? key,
    required Widget child,
    required this.scaffold,
    required this.routeInfo,
    required this.routeLayout,
    required this.showHeader,
  }) : super(key: key, child: child);

  ScaffoldBuilders get builders => scaffold.config.builders;

  ScaffoldWhether get whether => scaffold.config.whether;

  ScaffoldConfig get config => scaffold.config;

  RouteInfo get route => routeInfo;

  static ScaffoldInfo of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ScaffoldInfo>();
    assert(result != null, 'No ScaffoldInfo found in context');
    return result!;
  }

  static ScaffoldInfo? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScaffoldInfo>();
  }

  RouteLayout getLayout(LegendTheme theme) {
    return scaffold.routeLayout.get(theme.split);
  }

  bool showFooter(BuildContext context) {
    final layout =
        scaffold.routeLayout.get(LegendTheme.of(context).split).footerLayout;

    return layout is! NoFooterLayout;
  }

  @override
  bool updateShouldNotify(ScaffoldInfo oldWidget) {
    return oldWidget.routeLayout != oldWidget.routeLayout;
  }
}

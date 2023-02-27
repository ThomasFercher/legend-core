import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/config/dynamic_route_layout.dart';
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

  ScaffoldBuilders get builders => scaffold.builders;

  ScaffoldWhether get whether => scaffold.whether;

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
    return scaffold.dynamicLayout.getLayout(theme.sizing.key);
  }

  bool showFooter(BuildContext context) {
    final layout = scaffold.dynamicLayout
        .getLayout(LegendTheme.of(context).sizing.key)
        .footerLayout;

    return layout is! NoFooterLayout;
  }

  ScaffoldConfig get getConfig => ScaffoldConfig(
        builders: scaffold.builders,
        whether: scaffold.whether,
      );

  @override
  bool updateShouldNotify(ScaffoldInfo oldWidget) {
    return oldWidget != this;
  }
}

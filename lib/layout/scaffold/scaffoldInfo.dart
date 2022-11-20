import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/config/route_layout.dart';
import 'package:legend_design_core/layout/footer/footer_layout.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_router/router/legend_router.dart';

class ScaffoldInfo extends InheritedWidget {
  final LegendScaffold scaffold;
  final RouteInfo routeInfo;

  ScaffoldInfo({
    Key? key,
    required Widget child,
    required this.scaffold,
    required this.routeInfo,
  }) : super(key: key, child: child);

  static ScaffoldInfo of(BuildContext context) {
    final ScaffoldInfo? result =
        context.dependOnInheritedWidgetOfExactType<ScaffoldInfo>();
    assert(result != null, 'No ScaffoldInfo found in context');
    return result!;
  }

  RouteLayout getLayout(LegendTheme theme) {
    return scaffold.layout.getLayout(theme.sizing.key);
  }

  static ScaffoldBuilders getBuilders(BuildContext context) {
    return ScaffoldInfo.of(context).scaffold.builders;
  }

  static ScaffoldWhether whether(BuildContext context) {
    return ScaffoldInfo.of(context).scaffold.whether;
  }

  bool showFooter(BuildContext context) {
    final layout = scaffold.layout
        .getLayout(LegendTheme.of(context).sizing.key)
        .footerLayout;

    return layout != null;
  }

  ScaffoldConfig get getConfig => ScaffoldConfig(
        builders: scaffold.builders,
        whether: scaffold.whether,
        layout: scaffold.layout,
      );

  @override
  bool updateShouldNotify(ScaffoldInfo oldWidget) {
    return oldWidget != this;
  }
}

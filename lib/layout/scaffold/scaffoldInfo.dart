import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/provider.dart';

class ScaffoldInfo extends InheritedWidget {
  final LegendScaffold scaffold;

  ScaffoldInfo({
    Key? key,
    required Widget child,
    required this.scaffold,
  }) : super(key: key, child: child);

  static ScaffoldInfo of(BuildContext context) {
    final ScaffoldInfo? result =
        context.dependOnInheritedWidgetOfExactType<ScaffoldInfo>();
    assert(result != null, 'No ScaffoldInfo found in context');
    return result!;
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
        sizing: scaffold.sizing,
        layout: scaffold.layout,
      );

  @override
  bool updateShouldNotify(ScaffoldInfo old) {
    return old != this;
  }
}

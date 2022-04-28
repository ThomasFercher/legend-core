import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';

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

  ScaffoldConfig get getConfig => ScaffoldConfig(
        layoutType: scaffold.layoutType,
        builders: scaffold.builders,
        whether: scaffold.whether,
        sizing: scaffold.sizing,
      );

  @override
  bool updateShouldNotify(ScaffoldInfo old) {
    return old != this;
  }
}

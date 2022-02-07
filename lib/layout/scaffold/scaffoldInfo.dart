import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';

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

  @override
  bool updateShouldNotify(ScaffoldInfo old) {
    return old != this;
  }
}

import 'package:flutter/widgets.dart';
import 'package:legend_design_core/state/legend_state.dart';

class BottomBarInfo extends InheritedWidget {
  final BottomBarSizing sizing;
  final BottomBarColors colors;

  const BottomBarInfo({
    super.key,
    required super.child,
    required this.colors,
    required this.sizing,
  });

  static BottomBarInfo of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<BottomBarInfo>();
    assert(result != null, 'No LegendBottomBar found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(BottomBarInfo oldWidget) {
    return true;
  }
}

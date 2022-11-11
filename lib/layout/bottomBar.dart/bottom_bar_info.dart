import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/bottomBar.dart/legend_bottom_bar.dart';

class BottomBarInfo extends InheritedWidget {
  final LegendBottomBar bottomBar;

  const BottomBarInfo({
    super.key,
    required super.child,
    required this.bottomBar,
  });

  static LegendBottomBar of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<BottomBarInfo>();
    assert(result != null, 'No LegendBottomBar found in context');
    return result!.bottomBar;
  }

  @override
  bool updateShouldNotify(BottomBarInfo oldWidget) {
    return true;
  }
}

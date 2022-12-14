import 'package:flutter/widgets.dart';
import 'package:legend_design_core/libraries/scaffold.dart';

class RouteBodyInfo extends InheritedWidget {
  final LegendRouteBody info;
  final ScrollController scrollController;
  final BoxConstraints constraints;
  final bool showSliverBar;
  final bool showFooter;

  const RouteBodyInfo({
    super.key,
    required super.child,
    required this.info,
    required this.constraints,
    required this.scrollController,
    required this.showSliverBar,
    required this.showFooter,
  });

  static RouteBodyInfo of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<RouteBodyInfo>();
    assert(result != null, 'No RouteBodyInfo found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(RouteBodyInfo oldWidget) {
    return true;
  }
}

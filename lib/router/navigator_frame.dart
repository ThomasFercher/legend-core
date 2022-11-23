import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_frame.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_router/legend_router.dart';

class LegendNavigatorFrame extends NavigatorFrame {
  @override
  Widget buildFrame(
    BuildContext context,
    Navigator navigator,
    RouteInfo? current,
  ) {
    if (current is LegendRouteInfo) {
      return ScaffoldFrame(
        page: current,
        child: navigator,
      );
    } else {
      return navigator;
    }
  }
}

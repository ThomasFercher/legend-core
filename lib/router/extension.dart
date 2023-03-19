import 'package:flutter/widgets.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_router/legend_router.dart';

extension LegendRouterExtension on BuildContext {
  LegendRouter get legendRouter => LegendRouter.of(this);

  List<PageInfo> get menuRoutes => legendRouter
      .getTopRoutes<PageInfo>()
      .where((element) => element.isMenu)
      .toList();
}

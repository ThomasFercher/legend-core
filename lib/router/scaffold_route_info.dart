import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_router/legend_router.dart';

abstract class LegendRouteInfo extends PageRouteInfo {
  final ScaffoldConfigOverride? config;
  final bool isMenu;

  const LegendRouteInfo({
    required this.config,
    required super.name,
    required super.page,
    required super.title,
    this.isMenu = false,
    super.arguments,
    super.children,
    super.icon,
  });
}

class PageInfo extends LegendRouteInfo {
  const PageInfo({
    required super.name,
    required super.page,
    required super.title,
    super.config,
    super.isMenu,
    super.arguments,
    super.children,
    super.icon,
  });
}

import 'package:legend_router/legend_router.dart';
import 'layout_delegate.dart';

abstract class RoutesDelegate {
  const RoutesDelegate();

  List<RouteInfo> buildRoutes(
    LayoutInfo layouts,
  );
}

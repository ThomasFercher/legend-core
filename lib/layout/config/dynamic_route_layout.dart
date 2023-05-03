import 'route_layout.dart';

class DynamicRouteLayout {
  final Map<double, RouteLayout> layouts;

  const DynamicRouteLayout({
    required this.layouts,
  });

  RouteLayout get(double split) {
    return layouts[split] ?? layouts.values.first;
  }

  factory DynamicRouteLayout.override(
    List<double> splits, {
    required RouteLayout defaultLayout,
    Map<double, RouteLayoutOverride>? overrides,
  }) {
    final layouts = <double, RouteLayout>{
      for (final split in splits)
        split: RouteLayout.override(defaultLayout, overrides?[split])
    };

    return DynamicRouteLayout(layouts: layouts);
  }

  factory DynamicRouteLayout.single(
    List<double> splits, {
    required RouteLayout layout,
  }) {
    return DynamicRouteLayout(
      layouts: {
        for (final split in splits) split: layout,
      },
    );
  }
}

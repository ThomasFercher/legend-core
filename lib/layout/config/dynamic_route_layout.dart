import 'route_layout.dart';

class DynamicRouteLayout {
  final Map<double, RouteLayoutStyle> layouts;

  const DynamicRouteLayout({
    required this.layouts,
  });

  RouteLayoutStyle getLayout(double split) {
    return layouts[split] ?? layouts.values.first;
  }

  factory DynamicRouteLayout.override(
    List<double> splits, {
    required RouteLayoutStyle defaultLayout,
    Map<double, RouteLayoutOverride>? overrides,
  }) {
    final layouts = <double, RouteLayoutStyle>{
      for (final split in splits)
        split: RouteLayoutStyle.override(defaultLayout, overrides?[split])
    };

    return DynamicRouteLayout(layouts: layouts);
  }

  factory DynamicRouteLayout.single(
    List<double> splits, {
    required RouteLayoutStyle layout,
  }) {
    return DynamicRouteLayout(
      layouts: {
        for (final split in splits) split: layout,
      },
    );
  }
}

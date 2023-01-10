abstract class LegendCoreSizing implements LegendCoreSizingNull {
  /// Elevation
  @override
  final double elevation1;
  @override
  final double elevation2;
  @override
  final double elevation3;
  @override
  final double elevation4;

  /// Icon Sizes
  @override
  final double iconSize1;
  @override
  final double iconSize2;
  @override
  final double iconSize3;
  @override
  final double iconSize4;

  /// Border Radius
  @override
  final double radius1;
  @override
  final double radius2;
  @override
  final double radius3;
  @override
  final double radius4;

  // Spacing
  @override
  final double spacing1;
  @override
  final double spacing2;
  @override
  final double spacing3;
  @override
  final double spacing4;

  @override
  final Map<String, double> custom;

  const LegendCoreSizing({
    required this.elevation1,
    required this.elevation2,
    required this.elevation3,
    required this.elevation4,
    required this.iconSize1,
    required this.iconSize2,
    required this.iconSize3,
    required this.iconSize4,
    required this.radius1,
    required this.radius2,
    required this.radius3,
    required this.radius4,
    required this.spacing1,
    required this.spacing2,
    required this.spacing3,
    required this.spacing4,
    required this.custom,
  });
}

abstract class LegendCoreSizingNull {
  final double key;

  /// Elevation
  final double? elevation1;
  final double? elevation2;
  final double? elevation3;
  final double? elevation4;

  /// Icon Sizes
  final double? iconSize1;
  final double? iconSize2;
  final double? iconSize3;
  final double? iconSize4;

  /// Border Radius
  final double? radius1;
  final double? radius2;
  final double? radius3;
  final double? radius4;

  // Spacing
  final double? spacing1;
  final double? spacing2;
  final double? spacing3;
  final double? spacing4;

  final Map<String, double>? custom;

  const LegendCoreSizingNull({
    required this.key,
    this.custom,
    this.elevation1,
    this.elevation2,
    this.elevation3,
    this.elevation4,
    this.iconSize1,
    this.iconSize2,
    this.iconSize3,
    this.iconSize4,
    this.radius1,
    this.radius2,
    this.radius3,
    this.radius4,
    this.spacing1,
    this.spacing2,
    this.spacing3,
    this.spacing4,
  });
}

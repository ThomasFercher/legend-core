import 'dart:ui';

abstract class LegendCoreColors {
  ///  Primary Color
  final Color primary;

  ///  Secondary Color
  final Color secondary;

  ///  Tertiary Color
  final Color tertiary;

  /// Foreground colors. The color get darker with each index. The foreground Color
  /// of the index should work on the background color from the same index
  final Color foreground1;
  final Color foreground2;
  final Color foreground3;
  final Color foreground4;
  final Color foreground5;

  /// Background colors. The color get brighter with each index. The foreground Color
  /// of the index should work on the background color from the same index
  final Color background1;
  final Color background2;
  final Color background3;
  final Color background4;
  final Color background5;

  /// Error Color
  final Color error;

  /// Disabled Color
  final Color disabled;

  /// Selection Color. For example a selected Button will change to this color.
  final Color selection;

  /// Color ontop of the Primary Color
  final Color onPrimary;

  /// Color ontop of the Secondary Color
  final Color onSecondary;

  /// Color ontop of the Tertiary Color
  final Color onTertiary;

  final Map<String, Color> custom;

  const LegendCoreColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.foreground1,
    required this.foreground2,
    required this.foreground3,
    required this.foreground4,
    required this.foreground5,
    required this.background1,
    required this.background2,
    required this.background3,
    required this.background4,
    required this.background5,
    required this.error,
    required this.disabled,
    required this.selection,
    required this.onPrimary,
    required this.onSecondary,
    required this.onTertiary,
    required this.custom,
  });
}

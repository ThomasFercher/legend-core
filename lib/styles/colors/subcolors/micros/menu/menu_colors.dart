import 'dart:ui';
import 'package:legend_annotations/legend_annotations.dart';

part 'menu_colors.g.dart';

@legendStyle
abstract class MenuColorsStyle {
  final Color background;
  final Color activeForeground;
  final Color activeBackground;
  final Color foreground;
  final Color menuBackground;

  const MenuColorsStyle({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.menuBackground,
  });
}

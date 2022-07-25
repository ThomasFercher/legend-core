import 'dart:ui';
import 'package:legend_annotations/legend_annotations.dart';

part 'menu_colors.g.dart';

@legendStyle
class MenuColors {
  final Color background;
  final Color activeForeground;
  final Color activeBackground;
  final Color foreground;
  final Color menuBackground;

  const MenuColors({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.menuBackground,
  });
}

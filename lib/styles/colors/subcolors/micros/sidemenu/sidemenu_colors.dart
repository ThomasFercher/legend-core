import 'dart:ui';
import 'package:legend_annotations/legend_annotations.dart';

part 'sidemenu_colors.g.dart';

@legendStyle
abstract class SideMenuColorsStyle {
  final Color background;
  final Color activeForeground;
  final Color activeBackground;
  final Color foreground;
  final Color menuBackground;

  const SideMenuColorsStyle({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.menuBackground,
  });
}

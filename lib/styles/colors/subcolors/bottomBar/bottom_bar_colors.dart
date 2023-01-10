import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

part 'bottom_bar_colors.g.dart';

@legendStyle
abstract class BottomBarColorsStyle {
  final Color activeColor;
  final Color disabledColor;
  final Color backgroundColor;

  const BottomBarColorsStyle({
    required this.activeColor,
    required this.disabledColor,
    required this.backgroundColor,
  });
}

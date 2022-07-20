import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_utils/functions/functions.dart';

part 'bottom_bar_colors.g.dart';

@generateStyle
abstract class BottomBarColors {
  final Color activeColor;
  final Color disabledColor;
  final Color backgroundColor;

  const BottomBarColors({
    required this.activeColor,
    required this.disabledColor,
    required this.backgroundColor,
  });
}

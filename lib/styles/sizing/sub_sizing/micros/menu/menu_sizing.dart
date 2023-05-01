import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

part 'menu_sizing.g.dart';

@legendStyle
abstract class MenuSizingStyle {
  final double spacing;
  final double itemSpacing;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double height;
  final double iconSize;
  final BoxShadow? shadow;
  final BoxBorder? border;

  const MenuSizingStyle({
    required this.spacing,
    required this.borderRadius,
    required this.iconSize,
    required this.height,
    required this.padding,
    required this.itemSpacing,
    required this.shadow,
    required this.border,
  });
}

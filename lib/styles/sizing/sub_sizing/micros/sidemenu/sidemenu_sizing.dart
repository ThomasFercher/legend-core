import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

part 'sidemenu_sizing.g.dart';

@legendStyle
class SideMenuSizing {
  final double spacing;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final double itemHeight;
  final double iconSize;

  const SideMenuSizing({
    required this.spacing,
    required this.borderRadius,
    required this.iconSize,
    required this.itemHeight,
    required this.padding,
  });
}

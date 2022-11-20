import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';

part 'sider_sizing.g.dart';

@legendStyle
abstract class SiderSizingStyle {
  final double width;
  final double iconSize;
  final double spacing;
  final EdgeInsetsGeometry padding;
  @LegendSubStyle()
  final SideMenuSizingStyle sideMenuSizing;

  const SiderSizingStyle({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.padding,
    required this.sideMenuSizing,
  });
}

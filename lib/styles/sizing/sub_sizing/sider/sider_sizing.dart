import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';

part 'sider_sizing.g.dart';

@legendStyle
abstract class SiderSizing {
  final double width;
  final double iconSize;
  final double spacing;
  final double itemHeight;
  final double subMenuHeaderHeight;
  final EdgeInsets itemPadding;
  final EdgeInsets subItemPadding;
  final double horizontalPadding;
  late final SideMenuSizing sideMenuSizing;

  SiderSizing({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.subItemPadding,
    required this.itemPadding,
    required this.horizontalPadding,
    required this.sideMenuSizing,
  });
}

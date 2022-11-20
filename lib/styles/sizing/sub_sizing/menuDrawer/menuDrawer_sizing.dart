import 'package:flutter/material.dart';
import 'package:legend_annotations/legend_annotations.dart';

import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';

part 'menuDrawer_sizing.g.dart';

@legendStyle
abstract class MenuDrawerSizingStyle {
  final double width;
  final double iconSize;
  final double spacing;
  final double itemHeight;
  final double subMenuHeaderHeight;
  final double subMenuIconSize;
  final EdgeInsets itemPadding;
  final EdgeInsets subItemPadding;
  @LegendSubStyle()
  final SideMenuSizingStyle sideMenuSizing;

  MenuDrawerSizingStyle({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.subMenuIconSize,
    required this.subItemPadding,
    required this.itemPadding,
    required this.sideMenuSizing,
  });
}

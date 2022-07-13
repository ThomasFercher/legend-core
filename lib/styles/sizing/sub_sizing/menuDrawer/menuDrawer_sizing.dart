import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';

part 'menuDrawer_sizing.g.dart';

@generateStyle
abstract class MenuDrawerSizing {
  final double width;
  final double iconSize;
  final double spacing;
  final double itemHeight;
  final double subMenuHeaderHeight;
  final double subMenuIconSize;
  final EdgeInsets itemPadding;
  final EdgeInsets subItemPadding;
  late final SideMenuSizing sideMenuSizing;

  MenuDrawerSizing({
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

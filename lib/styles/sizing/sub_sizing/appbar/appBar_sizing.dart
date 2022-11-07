import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/menu/menu_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/tabbar/tabbar_sizing.dart';

part 'appBar_sizing.g.dart';

@legendStyle
abstract class AppBarSizing {
  final EdgeInsets contentPadding;
  final double logoSize;
  final double spacing;
  final double appBarHeight;
  final double iconSize;
  late final MenuSizing menuSizing;
  late final SideMenuSizing subMenuSizing;
  late final TabbarSizing? tabbarSizing;

  AppBarSizing({
    required this.appBarHeight,
    required this.contentPadding,
    required this.iconSize,
    required this.spacing,
    required this.logoSize,
    required this.menuSizing,
  });
}

import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/menu/menu_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/tabbar/tabbar_sizing.dart';

part 'appBar_sizing.g.dart';

@legendStyle
abstract class AppBarSizingStyle {
  final EdgeInsets contentPadding;
  final double logoSize;
  final double spacing;
  final double appBarHeight;
  final double iconSize;

  @LegendSubStyle()
  final MenuSizingStyle menuSizing;
  @LegendSubStyle()
  final SideMenuSizingStyle subMenuSizing;
  @LegendSubStyle()
  final TabbarSizingStyle? tabbarSizing;

  const AppBarSizingStyle(
    this.contentPadding,
    this.logoSize,
    this.spacing,
    this.appBarHeight,
    this.iconSize,
    this.menuSizing,
    this.subMenuSizing,
    this.tabbarSizing,
  );
}

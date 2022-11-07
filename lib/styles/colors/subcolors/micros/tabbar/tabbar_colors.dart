import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

part 'tabbar_colors.g.dart';

@legendStyle
abstract class TabbarColors {
  final Color background;

  const TabbarColors(this.background);
}

import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

part 'tabbar_colors.g.dart';

@legendStyle
abstract class TabbarColors {
  final Color background;
  final Color foreground;
  final Color selection;
  final Color disabled;

  const TabbarColors(
    this.background,
    this.disabled,
    this.foreground,
    this.selection,
  );
}

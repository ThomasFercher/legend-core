import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

part 'tabbar_colors.g.dart';

@legendStyle
abstract class TabbarColorsStyle {
  final Color background;
  final Color foreground;
  final Color selection;
  final Color disabled;

  const TabbarColorsStyle(
    this.background,
    this.disabled,
    this.foreground,
    this.selection,
  );
}

import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

part 'tabbar_sizing.g.dart';

@legendStyle
class TabbarSizingStyle {
  final double height;
  final MainAxisAlignment alignment;

  const TabbarSizingStyle({
    required this.height,
    required this.alignment,
  });
}

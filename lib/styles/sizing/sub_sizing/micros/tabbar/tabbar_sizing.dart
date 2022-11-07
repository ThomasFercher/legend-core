import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

part 'tabbar_sizing.g.dart';

@legendStyle
class TabbarSizing {
  final double height;
  final MainAxisAlignment alignment;

  const TabbarSizing({
    required this.height,
    required this.alignment,
  });
}

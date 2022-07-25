import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

part 'footer_sizing.g.dart';

@legendStyle
abstract class FooterSizing {
  final double height;
  final double maxWidth;
  final EdgeInsets padding;

  const FooterSizing({
    required this.height,
    required this.maxWidth,
    required this.padding,
  });
}

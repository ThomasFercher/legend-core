import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

part 'footer_sizing.g.dart';

@legendStyle
abstract class FooterSizingStyle {
  final double maxWidth;
  final EdgeInsets padding;

  const FooterSizingStyle({
    required this.maxWidth,
    required this.padding,
  });
}


// Flutter build runner command:
// flutter pub run build_runner build --delete-conflicting-outputs
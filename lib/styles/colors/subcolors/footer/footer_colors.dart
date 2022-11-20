import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_utils/functions/functions.dart';

part 'footer_colors.g.dart';

@legendStyle
abstract class FooterColorsStyle {
  final Color background;
  final Color foreground;

  const FooterColorsStyle({
    required this.background,
    required this.foreground,
  });
}

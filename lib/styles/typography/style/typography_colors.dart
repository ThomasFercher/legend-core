import 'dart:ui';

import 'package:legend_annotations/legend_annotations.dart';

part 'typography_colors.g.dart';

@legendStyle
class TypographyColors {
  final Color h0;
  final Color h1;
  final Color h2;
  final Color h3;
  final Color h4;
  final Color h5;

  const TypographyColors({
    required this.h0,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
  });

  factory TypographyColors.baseColor({required Color color}) {
    return TypographyColors(
      h0: color,
      h1: color,
      h2: color,
      h3: color,
      h4: color,
      h5: color,
    );
  }
}

import 'package:legend_annotations/legend_annotations.dart';

part 'typography_sizing.g.dart';

@legendStyle
abstract class TypographySizingStyle {
  final double h0;
  final double h1;
  final double h2;
  final double h3;
  final double h4;
  final double h5;

  const TypographySizingStyle({
    required this.h0,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
  });
}

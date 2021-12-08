import 'package:flutter/widgets.dart';

class FixedAppBarColors {
  final Color backgroundColor;

  final Color? cardColor;
  final Color iconColor;
  final Color selectedColor;
  final Color foreground;

  FixedAppBarColors({
    required this.backgroundColor,
    this.cardColor,
    required this.iconColor,
    required this.selectedColor,
    required this.foreground,
  });
}

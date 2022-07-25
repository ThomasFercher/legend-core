import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

part 'bottomBar_sizing.g.dart';

@legendStyle
class BottomBarSizing {
  /// A BoxDecoration for customising Boxshadows, BorderRadius, Borders, etc...
  final BoxDecoration decoration;

  /// The height of the appbar without margin
  final double height;

  /// Whether to show text
  final bool showText;

  /// Whether the text is beneath the icon
  final bool textAtBottom;

  /// The icon size
  final double iconSize;

  /// Spacing around the AppBar
  final EdgeInsets margin;

  /// Spacing around each of the Items
  final EdgeInsets itemPadding;

  /// Spacing around the Row of Items
  final EdgeInsets padding;

  /// Item Width
  final double itemWidth;

  /// The Aligment of the Items in the row
  final MainAxisAlignment alignment;

  /// Whether to fill the bottom
  final bool fillBottom;

  const BottomBarSizing({
    required this.showText,
    required this.textAtBottom,
    required this.fillBottom,
    required this.margin,
    required this.decoration,
    required this.height,
    required this.alignment,
    required this.iconSize,
    required this.itemPadding,
    required this.padding,
    required this.itemWidth,
  });
}

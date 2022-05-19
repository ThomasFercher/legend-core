import 'package:flutter/widgets.dart';

const BoxDecoration nullDecoration = BoxDecoration();
const double nullDouble = -123123;
const EdgeInsets nullEdgeInsets = EdgeInsets.zero;
const MainAxisAlignment nullAligment = MainAxisAlignment.start;

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

  BottomBarSizing({
    this.showText = false,
    this.textAtBottom = false,
    this.fillBottom = false,
    this.margin = nullEdgeInsets,
    this.decoration = nullDecoration,
    this.height = nullDouble,
    this.alignment = nullAligment,
    this.iconSize = nullDouble,
    this.itemPadding = nullEdgeInsets,
    this.padding = nullEdgeInsets,
    this.itemWidth = nullDouble,
  });

  factory BottomBarSizing.from({
    required BottomBarSizing? sizing,
    required bool showText,
    required bool textAtBottom,
    required bool fillBottom,
    required EdgeInsets margin,
    required BoxDecoration decoration,
    required double height,
    required MainAxisAlignment alignment,
    required double iconSize,
    required EdgeInsets padding,
    required EdgeInsets itemPadding,
    required double itemWidth,
  }) {
    if (sizing == null) {
      return BottomBarSizing(
        alignment: alignment,
        decoration: decoration,
        iconSize: iconSize,
        itemPadding: itemPadding,
        margin: margin,
        padding: padding,
        itemWidth: itemWidth,
      );
    } else {
      return BottomBarSizing(
        alignment:
            sizing.alignment == nullAligment ? alignment : sizing.alignment,
        decoration: sizing.decoration == nullDecoration
            ? decoration
            : sizing.decoration,
        iconSize: sizing.iconSize == nullDouble ? iconSize : sizing.iconSize,
        itemPadding: sizing.itemPadding == nullEdgeInsets
            ? itemPadding
            : sizing.itemPadding,
        margin: sizing.margin == nullEdgeInsets ? margin : sizing.margin,
        padding: sizing.padding == nullEdgeInsets ? padding : sizing.padding,
        height: sizing.height == nullDouble ? height : sizing.height,
        showText: sizing.showText != showText ? showText : sizing.showText,
        textAtBottom: sizing.textAtBottom != textAtBottom
            ? textAtBottom
            : sizing.textAtBottom,
        fillBottom:
            sizing.fillBottom != fillBottom ? fillBottom : sizing.fillBottom,
        itemWidth:
            sizing.itemWidth == nullDouble ? itemWidth : sizing.itemWidth,
      );
    }
  }
}

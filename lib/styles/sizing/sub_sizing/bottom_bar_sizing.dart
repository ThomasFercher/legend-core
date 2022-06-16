import 'package:flutter/widgets.dart';

abstract class BottomBarSizingInfo {
  /// A BoxDecoration for customising Boxshadows, BorderRadius, Borders, etc...
  final BoxDecoration? decoration;

  /// The height of the appbar without margin
  final double? height;

  /// Whether to show text
  final bool? showText;

  /// Whether the text is beneath the icon
  final bool? textAtBottom;

  /// The icon size
  final double? iconSize;

  /// Spacing around the AppBar
  final EdgeInsets? margin;

  /// Spacing around each of the Items
  final EdgeInsets? itemPadding;

  /// Spacing around the Row of Items
  final EdgeInsets? padding;

  /// Item Width
  final double? itemWidth;

  /// The Aligment of the Items in the row
  final MainAxisAlignment? alignment;

  /// Whether to fill the bottom
  final bool? fillBottom;

  const BottomBarSizingInfo({
    this.decoration,
    this.height,
    this.showText,
    this.textAtBottom,
    this.iconSize,
    this.margin,
    this.itemPadding,
    this.padding,
    this.itemWidth,
    this.alignment,
    this.fillBottom,
  });
}

class BottomBarSizingOverride extends BottomBarSizingInfo {
  const BottomBarSizingOverride({
    super.decoration,
    super.height,
    super.showText,
    super.textAtBottom,
    super.iconSize,
    super.margin,
    super.itemPadding,
    super.padding,
    super.itemWidth,
    super.alignment,
    super.fillBottom,
  });
}

class BottomBarSizing implements BottomBarSizingInfo {
  /// A BoxDecoration for customising Boxshadows, BorderRadius, Borders, etc...
  @override
  final BoxDecoration decoration;

  /// The height of the appbar without margin
  @override
  final double height;

  /// Whether to show text
  @override
  final bool showText;

  /// Whether the text is beneath the icon
  @override
  final bool textAtBottom;

  /// The icon size
  @override
  final double iconSize;

  /// Spacing around the AppBar
  @override
  final EdgeInsets margin;

  /// Spacing around each of the Items
  @override
  final EdgeInsets itemPadding;

  /// Spacing around the Row of Items
  @override
  final EdgeInsets padding;

  /// Item Width
  @override
  final double itemWidth;

  /// The Aligment of the Items in the row
  @override
  final MainAxisAlignment alignment;

  /// Whether to fill the bottom
  @override
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

  factory BottomBarSizing.override(
    BottomBarSizing def,
    BottomBarSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }

    return BottomBarSizing(
      showText: override.showText ?? def.showText,
      textAtBottom: override.textAtBottom ?? def.textAtBottom,
      fillBottom: override.fillBottom ?? def.fillBottom,
      margin: override.margin ?? def.margin,
      decoration: override.decoration ?? def.decoration,
      height: override.height ?? def.height,
      alignment: override.alignment ?? def.alignment,
      iconSize: override.iconSize ?? def.iconSize,
      itemPadding: override.itemPadding ?? def.itemPadding,
      padding: override.padding ?? def.padding,
      itemWidth: override.itemWidth ?? def.itemWidth,
    );
  }
}

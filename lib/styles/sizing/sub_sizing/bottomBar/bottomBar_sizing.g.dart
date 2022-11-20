// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottomBar_sizing.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class BottomBarSizingInfoNull {
  final BoxDecoration? decoration;
  final double? height;
  final bool? showText;
  final bool? textAtBottom;
  final double? iconSize;
  final EdgeInsets? margin;
  final EdgeInsets? itemPadding;
  final EdgeInsets? padding;
  final double? itemWidth;
  final MainAxisAlignment? alignment;
  final bool? fillBottom;
  const BottomBarSizingInfoNull({
    required this.decoration,
    required this.height,
    required this.showText,
    required this.textAtBottom,
    required this.iconSize,
    required this.margin,
    required this.itemPadding,
    required this.padding,
    required this.itemWidth,
    required this.alignment,
    required this.fillBottom,
  });
}

abstract class BottomBarSizingInfo implements BottomBarSizingInfoNull {
  @override
  final BoxDecoration decoration;
  @override
  final double height;
  @override
  final bool showText;
  @override
  final bool textAtBottom;
  @override
  final double iconSize;
  @override
  final EdgeInsets margin;
  @override
  final EdgeInsets itemPadding;
  @override
  final EdgeInsets padding;
  @override
  final double itemWidth;
  @override
  final MainAxisAlignment alignment;
  @override
  final bool fillBottom;
  const BottomBarSizingInfo({
    required this.decoration,
    required this.height,
    required this.showText,
    required this.textAtBottom,
    required this.iconSize,
    required this.margin,
    required this.itemPadding,
    required this.padding,
    required this.itemWidth,
    required this.alignment,
    required this.fillBottom,
  });
}

class BottomBarSizingOverride extends BottomBarSizingInfoNull {
  BottomBarSizingOverride({
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

class BottomBarSizing extends BottomBarSizingInfo {
  BottomBarSizing({
    required super.decoration,
    required super.height,
    required super.showText,
    required super.textAtBottom,
    required super.iconSize,
    required super.margin,
    required super.itemPadding,
    required super.padding,
    required super.itemWidth,
    required super.alignment,
    required super.fillBottom,
  });
  BottomBarSizing.copy({
    required super.decoration,
    required super.height,
    required super.showText,
    required super.textAtBottom,
    required super.iconSize,
    required super.margin,
    required super.itemPadding,
    required super.padding,
    required super.itemWidth,
    required super.alignment,
    required super.fillBottom,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory BottomBarSizing.override(
    BottomBarSizing def,
    BottomBarSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return BottomBarSizing(
      decoration: override.decoration ?? def.decoration,
      height: override.height ?? def.height,
      showText: override.showText ?? def.showText,
      textAtBottom: override.textAtBottom ?? def.textAtBottom,
      iconSize: override.iconSize ?? def.iconSize,
      margin: override.margin ?? def.margin,
      itemPadding: override.itemPadding ?? def.itemPadding,
      padding: override.padding ?? def.padding,
      itemWidth: override.itemWidth ?? def.itemWidth,
      alignment: override.alignment ?? def.alignment,
      fillBottom: override.fillBottom ?? def.fillBottom,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  BottomBarSizing copyWith({
    BoxDecoration? decoration,
    double? height,
    bool? showText,
    bool? textAtBottom,
    double? iconSize,
    EdgeInsets? margin,
    EdgeInsets? itemPadding,
    EdgeInsets? padding,
    double? itemWidth,
    MainAxisAlignment? alignment,
    bool? fillBottom,
  }) {
    return BottomBarSizing.copy(
      decoration: decoration ?? this.decoration,
      height: height ?? this.height,
      showText: showText ?? this.showText,
      textAtBottom: textAtBottom ?? this.textAtBottom,
      iconSize: iconSize ?? this.iconSize,
      margin: margin ?? this.margin,
      itemPadding: itemPadding ?? this.itemPadding,
      padding: padding ?? this.padding,
      itemWidth: itemWidth ?? this.itemWidth,
      alignment: alignment ?? this.alignment,
      fillBottom: fillBottom ?? this.fillBottom,
    );
  }
}

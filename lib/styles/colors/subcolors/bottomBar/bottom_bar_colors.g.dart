// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_bar_colors.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class BottomBarColorsInfoNull {
  final Color? activeColor;
  final Color? disabledColor;
  final Color? backgroundColor;
  const BottomBarColorsInfoNull({
    required this.activeColor,
    required this.disabledColor,
    required this.backgroundColor,
  });
}

abstract class BottomBarColorsInfo implements BottomBarColorsInfoNull {
  @override
  final Color activeColor;
  @override
  final Color disabledColor;
  @override
  final Color backgroundColor;
  const BottomBarColorsInfo({
    required this.activeColor,
    required this.disabledColor,
    required this.backgroundColor,
  });
}

class BottomBarColorsOverride extends BottomBarColorsInfoNull {
  BottomBarColorsOverride({
    super.activeColor,
    super.disabledColor,
    super.backgroundColor,
  });
}

class BottomBarColors extends BottomBarColorsInfo {
  BottomBarColors({
    required super.activeColor,
    required super.disabledColor,
    required super.backgroundColor,
  });
  BottomBarColors.copy({
    required super.activeColor,
    required super.disabledColor,
    required super.backgroundColor,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory BottomBarColors.override(
    BottomBarColors def,
    BottomBarColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return BottomBarColors(
      activeColor: override.activeColor ?? def.activeColor,
      disabledColor: override.disabledColor ?? def.disabledColor,
      backgroundColor: override.backgroundColor ?? def.backgroundColor,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  BottomBarColors copyWith({
    Color? activeColor,
    Color? disabledColor,
    Color? backgroundColor,
  }) {
    return BottomBarColors.copy(
      activeColor: activeColor ?? this.activeColor,
      disabledColor: disabledColor ?? this.disabledColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}

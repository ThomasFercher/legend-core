// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabbar_sizing.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class TabbarSizingInfoNull {
  final double? height;
  final MainAxisAlignment? alignment;
  const TabbarSizingInfoNull({
    required this.height,
    required this.alignment,
  });
}

abstract class TabbarSizingInfo implements TabbarSizingInfoNull {
  @override
  final double height;
  @override
  final MainAxisAlignment alignment;
  const TabbarSizingInfo({
    required this.height,
    required this.alignment,
  });
}

class TabbarSizingOverride extends TabbarSizingInfoNull {
  TabbarSizingOverride({
    super.height,
    super.alignment,
  });
}

class TabbarSizing extends TabbarSizingInfo {
  TabbarSizing({
    required super.height,
    required super.alignment,
  });
  TabbarSizing.copy({
    required super.height,
    required super.alignment,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory TabbarSizing.override(
    TabbarSizing def,
    TabbarSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return TabbarSizing(
      height: override.height ?? def.height,
      alignment: override.alignment ?? def.alignment,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  TabbarSizing copyWith({
    double? height,
    MainAxisAlignment? alignment,
  }) {
    return TabbarSizing.copy(
      height: height ?? this.height,
      alignment: alignment ?? this.alignment,
    );
  }
}

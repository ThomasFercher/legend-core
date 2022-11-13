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

class TabbarSizingStyle extends TabbarSizingInfo {
  TabbarSizingStyle({
    required super.height,
    required super.alignment,
  });
  factory TabbarSizingStyle.override(
    TabbarSizingStyle def,
    TabbarSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return TabbarSizingStyle(
      height: override.height ?? def.height,
      alignment: override.alignment ?? def.alignment,
    );
  }
}

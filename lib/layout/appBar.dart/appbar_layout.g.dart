// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appbar_layout.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class AppBarLayoutInfoNull {
  final AppBarLayoutConfig? layout;
  final AppBarLayoutType? aligment;
  final bool? showTabbar;
  const AppBarLayoutInfoNull({
    required this.layout,
    required this.aligment,
    required this.showTabbar,
  });
}

abstract class AppBarLayoutInfo implements AppBarLayoutInfoNull {
  @override
  final AppBarLayoutConfig layout;
  @override
  final AppBarLayoutType aligment;
  @override
  final bool showTabbar;
  const AppBarLayoutInfo({
    required this.layout,
    required this.aligment,
    required this.showTabbar,
  });
}

class AppBarLayoutOverride extends AppBarLayoutInfoNull {
  AppBarLayoutOverride({
    super.layout,
    super.aligment,
    super.showTabbar,
  });
}

class AppBarLayoutStyle extends AppBarLayoutInfo {
  AppBarLayoutStyle({
    required super.layout,
    required super.aligment,
    required super.showTabbar,
  });
  AppBarLayoutStyle.copy({
    required super.layout,
    required super.aligment,
    required super.showTabbar,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory AppBarLayoutStyle.override(
    AppBarLayoutStyle def,
    AppBarLayoutOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return AppBarLayoutStyle(
      layout: override.layout ?? def.layout,
      aligment: override.aligment ?? def.aligment,
      showTabbar: override.showTabbar ?? def.showTabbar,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  AppBarLayoutStyle copyWith({
    AppBarLayoutConfig? layout,
    AppBarLayoutType? aligment,
    bool? showTabbar,
  }) {
    return AppBarLayoutStyle.copy(
      layout: layout ?? this.layout,
      aligment: aligment ?? this.aligment,
      showTabbar: showTabbar ?? this.showTabbar,
    );
  }
}

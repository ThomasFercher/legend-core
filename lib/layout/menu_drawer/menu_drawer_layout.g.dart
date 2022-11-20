// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_drawer_layout.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class MenuDrawerLayoutInfoNull {
  final MenuDrawerLayoutType? type;
  const MenuDrawerLayoutInfoNull({
    required this.type,
  });
}

abstract class MenuDrawerLayoutInfo implements MenuDrawerLayoutInfoNull {
  @override
  final MenuDrawerLayoutType type;
  const MenuDrawerLayoutInfo({
    required this.type,
  });
}

class MenuDrawerLayoutOverride extends MenuDrawerLayoutInfoNull {
  MenuDrawerLayoutOverride({
    super.type,
  });
}

class MenuDrawerLayout extends MenuDrawerLayoutInfo {
  MenuDrawerLayout({
    required super.type,
  });
  MenuDrawerLayout.copy({
    required super.type,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory MenuDrawerLayout.override(
    MenuDrawerLayout def,
    MenuDrawerLayoutOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return MenuDrawerLayout(
      type: override.type ?? def.type,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  MenuDrawerLayout copyWith({
    MenuDrawerLayoutType? type,
  }) {
    return MenuDrawerLayout.copy(
      type: type ?? this.type,
    );
  }
}

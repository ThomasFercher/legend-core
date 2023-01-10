// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sider_layout.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class SiderLayoutInfoNull {
  final bool? left;
  const SiderLayoutInfoNull({
    required this.left,
  });
}

abstract class SiderLayoutInfo implements SiderLayoutInfoNull {
  @override
  final bool left;
  const SiderLayoutInfo({
    required this.left,
  });
}

class SiderLayoutOverride extends SiderLayoutInfoNull {
  SiderLayoutOverride({
    super.left,
  });
}

class SiderLayout extends SiderLayoutInfo {
  SiderLayout({
    required super.left,
  });
  SiderLayout.copy({
    required super.left,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory SiderLayout.override(
    SiderLayout def,
    SiderLayoutOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return SiderLayout(
      left: override.left ?? def.left,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  SiderLayout copyWith({
    bool? left,
  }) {
    return SiderLayout.copy(
      left: left ?? this.left,
    );
  }
}

class NoSiderLayout extends SiderLayout {
  NoSiderLayout() : super(left: false);
}

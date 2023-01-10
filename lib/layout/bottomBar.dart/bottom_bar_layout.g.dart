// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_bar_layout.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class BottomBarLayoutInfoNull {
  final BottomBarSelectionType? selectionType;
  const BottomBarLayoutInfoNull({
    required this.selectionType,
  });
}

abstract class BottomBarLayoutInfo implements BottomBarLayoutInfoNull {
  @override
  final BottomBarSelectionType selectionType;
  const BottomBarLayoutInfo({
    required this.selectionType,
  });
}

class BottomBarLayoutOverride extends BottomBarLayoutInfoNull {
  BottomBarLayoutOverride({
    super.selectionType,
  });
}

class BottomBarLayout extends BottomBarLayoutInfo {
  BottomBarLayout({
    required super.selectionType,
  });
  BottomBarLayout.copy({
    required super.selectionType,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory BottomBarLayout.override(
    BottomBarLayout def,
    BottomBarLayoutOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return BottomBarLayout(
      selectionType: override.selectionType ?? def.selectionType,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  BottomBarLayout copyWith({
    BottomBarSelectionType? selectionType,
  }) {
    return BottomBarLayout.copy(
      selectionType: selectionType ?? this.selectionType,
    );
  }
}

class NoBottomBarLayout extends BottomBarLayout {
  NoBottomBarLayout()
      : super(
          selectionType: BottomBarSelectionType.values.first,
        );
}

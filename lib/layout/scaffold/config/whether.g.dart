// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whether.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class ScaffoldWhetherInfoNull {
  final bool? showSiderMenu;
  final bool? showSiderSubMenu;
  final bool? showAppBarMenu;
  final bool? showTopSubMenu;
  final bool? showSiderChildMenu;
  final bool? shareParentSiderMenu;
  final bool? singlePage;
  final bool? showBackButton;
  const ScaffoldWhetherInfoNull({
    required this.showSiderMenu,
    required this.showSiderSubMenu,
    required this.showAppBarMenu,
    required this.showTopSubMenu,
    required this.showSiderChildMenu,
    required this.shareParentSiderMenu,
    required this.singlePage,
    required this.showBackButton,
  });
}

abstract class ScaffoldWhetherInfo implements ScaffoldWhetherInfoNull {
  @override
  final bool showSiderMenu;
  @override
  final bool showSiderSubMenu;
  @override
  final bool showAppBarMenu;
  @override
  final bool showTopSubMenu;
  @override
  final bool showSiderChildMenu;
  @override
  final bool shareParentSiderMenu;
  @override
  final bool singlePage;
  @override
  final bool showBackButton;
  const ScaffoldWhetherInfo({
    required this.showSiderMenu,
    required this.showSiderSubMenu,
    required this.showAppBarMenu,
    required this.showTopSubMenu,
    required this.showSiderChildMenu,
    required this.shareParentSiderMenu,
    required this.singlePage,
    required this.showBackButton,
  });
}

class ScaffoldWhetherOverride extends ScaffoldWhetherInfoNull {
  ScaffoldWhetherOverride({
    super.showSiderMenu,
    super.showSiderSubMenu,
    super.showAppBarMenu,
    super.showTopSubMenu,
    super.showSiderChildMenu,
    super.shareParentSiderMenu,
    super.singlePage,
    super.showBackButton,
  });
}

class ScaffoldWhether extends ScaffoldWhetherInfo {
  ScaffoldWhether({
    required super.showSiderMenu,
    required super.showSiderSubMenu,
    required super.showAppBarMenu,
    required super.showTopSubMenu,
    required super.showSiderChildMenu,
    required super.shareParentSiderMenu,
    required super.singlePage,
    required super.showBackButton,
  });
  ScaffoldWhether.copy({
    required super.showSiderMenu,
    required super.showSiderSubMenu,
    required super.showAppBarMenu,
    required super.showTopSubMenu,
    required super.showSiderChildMenu,
    required super.shareParentSiderMenu,
    required super.singlePage,
    required super.showBackButton,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory ScaffoldWhether.override(
    ScaffoldWhether def,
    ScaffoldWhetherOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return ScaffoldWhether(
      showSiderMenu: override.showSiderMenu ?? def.showSiderMenu,
      showSiderSubMenu: override.showSiderSubMenu ?? def.showSiderSubMenu,
      showAppBarMenu: override.showAppBarMenu ?? def.showAppBarMenu,
      showTopSubMenu: override.showTopSubMenu ?? def.showTopSubMenu,
      showSiderChildMenu: override.showSiderChildMenu ?? def.showSiderChildMenu,
      shareParentSiderMenu:
          override.shareParentSiderMenu ?? def.shareParentSiderMenu,
      singlePage: override.singlePage ?? def.singlePage,
      showBackButton: override.showBackButton ?? def.showBackButton,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  ScaffoldWhether copyWith({
    bool? showSiderMenu,
    bool? showSiderSubMenu,
    bool? showAppBarMenu,
    bool? showTopSubMenu,
    bool? showSiderChildMenu,
    bool? shareParentSiderMenu,
    bool? singlePage,
    bool? showBackButton,
  }) {
    return ScaffoldWhether.copy(
      showSiderMenu: showSiderMenu ?? this.showSiderMenu,
      showSiderSubMenu: showSiderSubMenu ?? this.showSiderSubMenu,
      showAppBarMenu: showAppBarMenu ?? this.showAppBarMenu,
      showTopSubMenu: showTopSubMenu ?? this.showTopSubMenu,
      showSiderChildMenu: showSiderChildMenu ?? this.showSiderChildMenu,
      shareParentSiderMenu: shareParentSiderMenu ?? this.shareParentSiderMenu,
      singlePage: singlePage ?? this.singlePage,
      showBackButton: showBackButton ?? this.showBackButton,
    );
  }
}

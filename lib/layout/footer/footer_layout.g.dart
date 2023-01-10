// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footer_layout.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class FooterLayoutInfoNull {}

abstract class FooterLayoutInfo implements FooterLayoutInfoNull {}

class FooterLayoutOverride extends FooterLayoutInfoNull {
  FooterLayoutOverride();
}

class FooterLayout extends FooterLayoutInfo {
  FooterLayout();
  FooterLayout.copy();

// **************************************************************************
// Override
// **************************************************************************
  factory FooterLayout.override(
    FooterLayout def,
    FooterLayoutOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    if (override is NoFooterLayoutOverride) {
      return NoFooterLayout();
    }
    return FooterLayout();
  }

// **************************************************************************
// Copy With
// **************************************************************************
  FooterLayout copyWith() {
    return FooterLayout.copy();
  }
}

class NoFooterLayout extends FooterLayout {
  NoFooterLayout();
}

class NoFooterLayoutOverride extends FooterLayoutOverride {
  NoFooterLayoutOverride();
}

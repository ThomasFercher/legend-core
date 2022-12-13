import 'package:flutter/material.dart';

///
/// Will only work in InnerBoxDecoration
///
class InnerBoxShadow extends BoxShadow {
  final bool inside;

  const InnerBoxShadow({
    this.inside = true,
    super.blurRadius,
    super.blurStyle,
    super.color,
    super.offset,
    super.spreadRadius,
  });
}

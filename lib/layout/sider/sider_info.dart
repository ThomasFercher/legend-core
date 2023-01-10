import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/sider/fixed_sider.dart';

class SiderInfo extends InheritedWidget {
  final LegendSider fixedSider;

  const SiderInfo({
    super.key,
    required super.child,
    required this.fixedSider,
  });

  static SiderInfo? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SiderInfo>();
  }

  @override
  bool updateShouldNotify(SiderInfo oldWidget) {
    return true;
  }
}

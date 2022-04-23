import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/sider/fixed_sider.dart';

class SiderInfo extends InheritedWidget {
  final LegendSider fixedSider;

  SiderInfo({
    Key? key,
    required this.child,
    required this.fixedSider,
  }) : super(key: key, child: child);

  @override
  final Widget child;

  static SiderInfo? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SiderInfo>();
  }

  @override
  bool updateShouldNotify(SiderInfo oldWidget) {
    return true;
  }
}

import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/sider/siderInfo.dart';
import 'normal/legend_sider.dart';

class LegendSider extends StatelessWidget {
  final bool showMenu;
  final bool showChildMenu;
  final bool showSubMenu;
  final bool enableDefaultSettings;
  final WidgetBuilder? builder;
  final bool showParentMenu;
  final bool collapsed;

  const LegendSider({
    this.showMenu = true,
    this.showSubMenu = false,
    this.showChildMenu = false,
    this.enableDefaultSettings = false,
    this.showParentMenu = false,
    this.builder,
    this.collapsed = false,
  });

  @override
  Widget build(BuildContext context) {
    return SiderInfo(
      fixedSider: this,
      child: const Sider(),
    );
  }
}

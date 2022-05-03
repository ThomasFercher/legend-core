import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/sider/siderInfo.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'normal/legend_sider.dart';

class LegendSider extends StatelessWidget {
  final bool showMenu;
  final bool showChildMenu;
  final bool showSubMenu;
  final LayoutType layoutType;
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
    this.layoutType = LayoutType.FixedHeader,
  });

  @override
  Widget build(BuildContext context) {
    return SiderInfo(
      fixedSider: this,
      child: const Sider(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/sider/siderInfo.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';

import 'collapsed/collapsedSider.dart';
import 'normal/legend_sider.dart';

class FixedSider extends StatelessWidget {
  final bool showMenu;
  final bool showSectionMenu;
  final bool showChildMenu;
  final bool showSubMenu;
  final LayoutType layoutType;
  final bool enableDefaultSettings;
  final WidgetBuilder? builder;
  final bool showParentMenu;
  final bool collapsed;

  const FixedSider({
    this.showMenu = true,
    this.showSectionMenu = false,
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
    return Hero(
      tag: ValueKey('sider'),
      child: SiderInfo(
        fixedSider: this,
        child: Material(
          elevation: 0,
          child: !collapsed
              ? const Sider()
              : CollapsedSider(
                  context: context,
                  showMenu: showMenu,
                  showSectionMenu: showSectionMenu,
                  showSubMenu: showChildMenu,
                  layoutType: layoutType,
                ),
        ),
      ),
    );
  }
}

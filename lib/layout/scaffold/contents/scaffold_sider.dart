import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/layout/sider/fixed_sider.dart';
import 'package:legend_design_core/layout/sider/sider_layout.dart';
import 'package:legend_design_core/state/legend_state.dart';

class ScaffoldSider extends LegendWidget {
  const ScaffoldSider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;
    final layout = scaffold.routeLayout.get(theme.sizing.key);

    if (layout.siderLayout is NoSiderLayout) {
      return SizedBox.shrink();
    }

    return LegendSider(
      builder: scaffold.config.builders.siderBuilder,
      showMenu: scaffold.config.whether.showSiderMenu,
      showSubMenu: scaffold.config.whether.showSiderSubMenu,
      showChildMenu: scaffold.config.whether.showSiderChildMenu,
      showParentMenu: scaffold.config.whether.shareParentSiderMenu,
    );
  }
}

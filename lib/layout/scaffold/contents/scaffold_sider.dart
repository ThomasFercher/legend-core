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
    final layout = scaffold.dynamicLayout.getLayout(theme.sizing.key);

    if (layout.siderLayout is NoSiderLayout) {
      return SizedBox.shrink();
    }

    return LegendSider(
      builder: scaffold.builders.siderBuilder,
      showMenu: scaffold.whether.showSiderMenu,
      showSubMenu: scaffold.whether.showSiderSubMenu,
      showChildMenu: scaffold.whether.showSiderChildMenu,
      showParentMenu: scaffold.whether.shareParentSiderMenu,
    );
  }
}

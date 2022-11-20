import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/layout/sider/fixed_sider.dart';
import 'package:legend_design_core/state/legend_state.dart';
import '../../config/route_layout.dart';

class ScaffoldSider extends LegendWidget {
  const ScaffoldSider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;
    final layout = scaffold.layout.getLayout(theme.sizing.key);

    if (layout.siderLayout == null) {
      return Container();
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 4,
            blurRadius: 8,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: LegendSider(
        builder: scaffold.builders.siderBuilder,
        showMenu: scaffold.whether.showSiderMenu,
        showSubMenu: scaffold.whether.showSiderSubMenu,
        showChildMenu: scaffold.whether.showSiderChildMenu,
        showParentMenu: scaffold.whether.shareParentSiderMenu,
      ),
    );
  }
}

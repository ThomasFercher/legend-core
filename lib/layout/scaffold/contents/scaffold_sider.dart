import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/sider/fixed_sider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/provider.dart';

class ScaffoldSider extends StatelessWidget {
  const ScaffoldSider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;
    LegendTheme theme = context.watch<LegendTheme>();

    RouteLayout layout = scaffold.layout.getLayout(theme.sizingTheme.key);
    if (layout.siderLayout != SiderLayout.None) {
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
    } else {
      return Container();
    }
  }
}

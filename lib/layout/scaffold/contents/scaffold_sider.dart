import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/sider/fixed_sider.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/provider.dart';

class ScaffoldSider extends StatelessWidget {
  const ScaffoldSider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;
    LegendTheme theme = context.watch<LegendTheme>();

    bool layout = (scaffold.layoutType == LayoutType.FixedSider ||
        scaffold.layoutType == LayoutType.FixedHeaderSider);
    bool showSider = layout && !theme.sizing.hideSider;

    bool collapsed = theme.sizing.collapsedSider;

    if (showSider) {
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
          showMenu: scaffold.whether.showSiderMenu ?? false,
          showSubMenu: scaffold.whether.showSiderSubMenu ?? false,
          showSectionMenu: scaffold.whether.showSectionMenu ?? false,
          layoutType: scaffold.layoutType,
          showChildMenu: scaffold.whether.showSiderChildMenu ?? false,
          showParentMenu: scaffold.whether.shareParentSiderMenu ?? false,
          collapsed: collapsed,
        ),
      );
    } else {
      return Container();
    }
  }
}

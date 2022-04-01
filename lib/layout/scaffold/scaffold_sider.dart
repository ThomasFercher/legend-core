import 'package:flutter/cupertino.dart';
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
      return FixedSider(
        builder: scaffold.siderBuilder,
        showMenu: scaffold.showSiderMenu,
        showSubMenu: scaffold.showSiderSubMenu,
        showSectionMenu: scaffold.showSectionMenu,
        layoutType: scaffold.layoutType,
        showChildMenu: scaffold.showSiderChildMenu,
        showParentMenu: scaffold.shareParentSiderMenu,
        collapsed: collapsed,
      );
    } else {
      return Container();
    }
  }
}

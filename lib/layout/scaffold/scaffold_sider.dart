import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/fixed/sider/fixed_sider.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/theming/sizing/size_provider.dart';

class ScaffoldSider extends StatelessWidget {
  const ScaffoldSider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;
    ScreenSize screenSize = SizeProvider.of(context).screenSize;

    if ((scaffold.layoutType == LayoutType.FixedSider ||
            scaffold.layoutType == LayoutType.FixedHeaderSider) &&
        screenSize != ScreenSize.Small) {
      return FixedSider(
        builder: scaffold.siderBuilder,
        showMenu: scaffold.showSiderMenu,
        showSubMenu: scaffold.showSiderSubMenu,
        showSectionMenu: scaffold.showSectionMenu,
        layoutType: scaffold.layoutType,
        showChildMenu: scaffold.showSiderChildMenu,
      );
    } else {
      return Container();
    }
  }
}

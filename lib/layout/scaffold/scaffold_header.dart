import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:provider/provider.dart';

import '../../styles/layouts/layout_type.dart';
import '../../styles/legend_theme.dart';
import '../../styles/sizing/size_info.dart';
import '../fixed/appBar.dart/fixed_appbar.dart';
import 'legend_scaffold.dart';

class ScaffoldHeader extends StatelessWidget {
  const ScaffoldHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;

    bool bottomBar =
        theme.sizing.showBottomBar || SizeInfo.of(context).isMobile;
    bool showMenu = !bottomBar && scaffold.showAppBarMenu;

    switch (scaffold.layoutType) {
      case LayoutType.FixedHeaderSider:
        return FixedAppBar(
          showMenu: showMenu,
          builder: scaffold.appBarBuilder,
          layoutType: scaffold.layoutType,
          showSubMenu: scaffold.showTopSubMenu,
          context: context,
        );
      case LayoutType.FixedHeader:
        return FixedAppBar(
          builder: scaffold.appBarBuilder,
          showMenu: showMenu,
          layoutType: scaffold.layoutType,
          showSubMenu: scaffold.showTopSubMenu,
          context: context,
        );
      default:
        return SliverToBoxAdapter(
          child: Container(),
        );
    }
  }
}

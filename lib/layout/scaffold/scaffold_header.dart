import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:provider/provider.dart';

import '../../styles/layouts/layout_type.dart';
import '../../styles/theming/sizing/size_provider.dart';
import '../../styles/theming/theme_provider.dart';
import '../fixed/appBar.dart/fixed_appbar.dart';
import 'legend_scaffold.dart';

class ScaffoldHeader extends StatelessWidget {
  const ScaffoldHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();
    bool isMobile = SizeProvider.of(context).isMobile;
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;
    switch (scaffold.layoutType) {
      case LayoutType.FixedHeaderSider:
        return FixedAppBar(
          showMenu: !isMobile ? scaffold.showAppBarMenu : false,
          builder: scaffold.appBarBuilder,
          layoutType: scaffold.layoutType,
          showSubMenu: scaffold.showTopSubMenu,
        );
      case LayoutType.FixedHeader:
        return FixedAppBar(
          builder: scaffold.appBarBuilder,
          showMenu: !isMobile ? scaffold.showAppBarMenu : false,
          layoutType: scaffold.layoutType,
          showSubMenu: scaffold.showTopSubMenu,
        );
      default:
        return SliverToBoxAdapter(
          child: Container(),
        );
    }
  }
}

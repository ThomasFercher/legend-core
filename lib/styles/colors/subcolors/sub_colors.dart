import 'package:legend_design_core/styles/colors/subcolors/menuDrawer/menu_drawer_colors.dart';
import 'package:legend_design_core/styles/legend_theme.dart';

class LegendSubColors {
  final AppBarColorsOverride? appBar;
  final BottomBarColorsOverride? bottomBar;
  final SiderColorOverride? sider;
  final MenuDrawerColorOverride? menuDrawer;
  final FooterColorOverride? footer;

  const LegendSubColors({
    this.appBar,
    this.bottomBar,
    this.sider,
    this.menuDrawer,
    this.footer,
  });
}

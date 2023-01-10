import 'package:legend_design_core/styles/colors/subcolors/appbar/appBar_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/menuDrawer/menu_drawer_colors.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/style/typography_colors.dart';

class LegendSubColors {
  final AppBarColorsOverride? appBar;
  final BottomBarColorsOverride? bottomBar;
  final SiderColorsOverride? sider;
  final MenuDrawerColorsOverride? menuDrawer;
  final FooterColorsOverride? footer;
  final TypographyColorsOverride? typography;

  const LegendSubColors({
    this.appBar,
    this.bottomBar,
    this.sider,
    this.menuDrawer,
    this.footer,
    this.typography,
  });
}

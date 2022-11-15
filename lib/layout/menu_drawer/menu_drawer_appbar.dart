import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_provider.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/fixed_sider_menu.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';

const Duration duration = Duration(milliseconds: 250);
const Duration reverseDuration = Duration(milliseconds: 200);

class MenuDrawerAppBar extends StatelessWidget {
  const MenuDrawerAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    final width = SizeInfo.of(context).width;
    final sizing = theme.menuDrawerSizing;
    final colors = theme.menuDrawerColors;

    final menuSizing = sizing.sideMenuSizing.copyWith(
      spacing: 0,
      borderRadius: BorderRadius.zero,
      padding: EdgeInsets.only(
        left: 32,
      ),
    );

    final menuColors = colors.menuColors.copyWith(
      background: theme.appBarColors.background,
      menuBackground: theme.appBarColors.background,
      foreground: theme.appBarColors.foreground,
    );
    final provider = context.watch<AppBarProvider>();
    final menuDrawerOpen = provider.showMenu;

    if (provider.hideMenu) {
      provider.hideMenu = false;
      return SizedBox.shrink();
    }

    final maxHeight = LegendRouter.of(context).topRoutes.length *
        (menuSizing.spacing + menuSizing.itemHeight);

    final minHeightC = menuDrawerOpen ? maxHeight : 0.0;
    final maxHeightC = menuDrawerOpen ? SizeInfo.of(context).height * 0.6 : 0.0;
    return AnimatedContainer(
      duration: duration,
      curve: Curves.easeInOutSine,
      constraints: BoxConstraints(
        minHeight: minHeightC,
        maxHeight: maxHeightC,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: menuColors.background,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(6),
          ),
        ),
        child: FixedSiderMenu(
          current: LegendRouter.of(context).current?.name,
          width: width,
          options: LegendRouter.of(context).topRoutes,
          showMenuSubItems: true,
          colors: menuColors,
          sizing: menuSizing,
          textStyle: theme.typography.h2,
          hasToPopMenuDrawer: true,
        ),
      ),
    );
  }
}

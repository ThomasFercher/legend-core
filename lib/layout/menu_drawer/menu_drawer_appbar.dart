import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_provider.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/fixed_sider_menu.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';

const Duration duration = Duration(milliseconds: 300);
const Duration reverseDuration = Duration(milliseconds: 200);

class MenuDrawerAppBar extends HookWidget {
  const MenuDrawerAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    final width = SizeInfo.of(context).width;
    final sizing = theme.menuDrawerSizing;
    final colors = theme.menuDrawerColors;
    final menuSizing = sizing.sideMenuSizing;
    final menuColors = colors.menuColors;
    final menuDrawerOpen = context.watch<AppBarProvider>().showMenu;
    final maxHeight = LegendRouter.of(context).topRoutes.length *
        (menuSizing.spacing + menuSizing.itemHeight);

    final controller = useAnimationController(
      duration: duration,
      reverseDuration: reverseDuration,
    );
    final animation = Tween<double>(begin: 0, end: maxHeight).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    if (menuDrawerOpen) {
      controller.forward();
    } else {
      controller.reverse();
    }

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        if (!menuDrawerOpen && !controller.isAnimating) {
          return SizedBox.shrink();
        }

        return Container(
          color: theme.appBarColors.background,
          height: animation.value,

          //  width: SizeInfo.of(context).width,
          child: OverflowBox(
            child: FixedSiderMenu(
              width: width,
              options: LegendRouter.of(context).topRoutes,
              showMenuSubItems: false,
              colors: menuColors,
              sizing: menuSizing,
              textStyle: theme.typography.h2,
            ),
          ),
        );
      },
    );
  }
}

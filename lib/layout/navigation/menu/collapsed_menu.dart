import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_provider.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer_layout.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';

class CollapsedMenu extends LegendWidget {
  final double width;

  const CollapsedMenu({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    LegendTheme theme = LegendTheme.of(context);
    final layout = ScaffoldInfo.of(context).getLayout(theme);

    final useMenuDrawerAppBar =
        layout.menuDrawerLayout?.type == MenuDrawerLayoutType.beneathAppBar;

    var icon = Icons.menu;

    if (useMenuDrawerAppBar) {
      if (context.watch<AppBarProvider>().showMenu) {
        icon = Icons.close_rounded;
      }
    }

    return Container(
      width: width,
      alignment: Alignment.center,
      child: LegendAnimatedIcon(
        padding: EdgeInsets.all(0),
        iconSize: theme.appBarSizing.iconSize,
        onPressed: () {
          if (useMenuDrawerAppBar) {
            context.read<AppBarProvider>().toggle();
          } else {
            ModalRouter.of(context).push('/menudrawer');
          }
        },
        icon: icon,
        disableShadow: true,
        theme: LegendAnimtedIconTheme(
          disabled: theme.colors.appBar.foreground,
          enabled: theme.colors.selection,
        ),
      ),
    );
  }
}

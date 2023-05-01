import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_provider.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer_layout.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/state/provider/legend_provider.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';

class CollapsedMenu extends LegendWidget {
  final double width;
  final BoxDecoration decoration;

  const CollapsedMenu({
    super.key,
    required this.width,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final theme = LegendTheme.of(context);
    final layout = ScaffoldInfo.of(context).getLayout(theme);

    final useMenuDrawerAppBar =
        layout.menuDrawerLayout.type == MenuDrawerLayoutType.beneathAppBar;

    var icon = theme.typography.menuIcon;

    if (useMenuDrawerAppBar) {
      if (LegendProvider.of<AppBarProvider>(context).showMenu) {
        icon = theme.typography.closeIcon;
      }
    }

    return Container(
      width: width,
      alignment: Alignment.center,
      decoration: decoration,
      child: LegendAnimatedIcon(
        iconSize: theme.appBarSizing.iconSize,
        onPressed: () {
          if (useMenuDrawerAppBar) {
            ProviderWrapper.of<AppBarProvider>(context).update(
              (old) {
                return old.copyWith(
                  showMenu: !old.showMenu,
                );
              },
            );
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

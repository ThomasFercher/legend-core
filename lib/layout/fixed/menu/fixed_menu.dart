import 'package:flutter/material.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/provider.dart';

class FixedMenu extends StatelessWidget {
  final void Function(MenuOptionHeader option)? onSelected;
  final bool? showIconsOnly;
  final Color? iconColor;
  final Color? selected;
  final Color? backgroundColor;
  final Color? foreground;
  final bool showSubMenu;

  final GlobalKey _key = GlobalKey();

  FixedMenu({
    required this.showSubMenu,
    this.onSelected,
    this.showIconsOnly,
    this.iconColor,
    this.selected,
    this.backgroundColor,
    this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = Provider.of<LegendTheme>(context);
    MenuOption? sel = RouteInfoProvider.getCurrentMenuOption(context);

    List<MenuOption> options = LegendRouter.of(context).menuOptions;

    List<MenuOptionHeader> headers = [];

    for (final option in options) {
      if (option.showInAppBar) {
        headers.add(
          MenuOptionHeader(
            option: option,
            activeColor: selected,
            color: foreground,
            backgroundColor: backgroundColor,
            showSubMenu: showSubMenu,
            forceColor: option == sel,
          ),
        );
      }
    }

    return Container(
      //  margin: const EdgeInsets.only(left: 16.0),

      height: theme.appBarSizing.appBarHeight,
      key: _key,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return headers[index];
            },
            separatorBuilder: (context, index) {
              return Container(
                width: theme.appBarSizing.spacing,
              );
            },
            itemCount: headers.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          );
        },
      ),
    );
  }
}

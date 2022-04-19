import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/fixed/menu/fixed_menu.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/provider.dart';

const List<Widget> actionsFiller = [
  SizedBox(
    height: 0,
    width: 0,
  )
];

class LegendAppBar extends StatelessWidget {
  final LegendAppBarConfig config;
  final List<Widget>? actions;
  final Widget? title;
  final Widget? logo;
  final bool showMenu;

  const LegendAppBar({
    required this.config,
    this.actions,
    this.logo,
    this.title,
    this.showMenu = true,
  });

  Widget getLogo(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();

    return GestureDetector(
      onTap: () {
        if (RouteInfoProvider.of(context)?.route.name != '/') {
          LegendRouter.of(context).pushPage(
            settings: const RouteSettings(name: '/'),
          );
        }
      },
      child: logo ??
          Container(
            width: theme.appBarSizing.titleSize ?? 64,
            height: theme.appBarSizing.titleSize ?? 64,
            margin: EdgeInsets.only(
              right: 6,
            ),
            alignment: Alignment.centerRight,
            child: LayoutProvider.of(context)!.logo,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    return SliverAppBar(
      leadingWidth: 0,
      titleSpacing: 0,
      elevation: config.elevation,
      toolbarHeight: config.appBarHeight,
      pinned: config.pinned,
      snap: config.snap,
      floating: config.floating,
      actions: actionsFiller,
      title: Container(
        constraints: BoxConstraints(maxHeight: config.appBarHeight),
        padding: EdgeInsets.symmetric(horizontal: config.horizontalPadding),
        child: AppBarLayout(
          children: {
            AppBarItem.TITLE: title ??
                LegendText(
                  text: LayoutProvider.of(context)!.title!,
                  textStyle: theme.typography.h6.copyWith(
                    color: theme.colors.appBarPalette.foreground,
                  ),
                ),
            AppBarItem.LOGO: getLogo(context),
            if (showMenu)
              AppBarItem.MENU: FixedMenu(
                showSubMenu: false,
                backgroundColor: theme.colors.appBarPalette.background,
                foreground: theme.colors.appBarPalette.foreground,
                selected: theme.colors.appBarPalette.selected,
              ),
            if (actions != null && actions!.isNotEmpty)
              AppBarItem.ACTIONS: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!
                    .traillingPaddingRow(config.actionSpaceing, last: true),
              ),
          },
        ),
      ),
    );
  }
}

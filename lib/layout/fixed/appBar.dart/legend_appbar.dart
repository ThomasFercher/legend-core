import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/fixed/menu/fixed_menu.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/fixed_sider_menu.dart';
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
  final WidgetBuilder? actions;
  final Widget? title;
  final Widget? logo;
  final bool showMenu;
  final bool showTitle;
  final bool showLogo;
  final AppBarLayoutType type;

  const LegendAppBar({
    required this.config,
    this.actions,
    this.logo,
    this.title,
    this.showMenu = true,
    this.showLogo = true,
    this.showTitle = true,
    required this.type,
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
            width: theme.appBarSizing.logoSize,
            height: theme.appBarSizing.logoSize,
            alignment: Alignment.center,
            child: LayoutProvider.of(context)!.logo,
          ),
    );
  }

  FixedMenu getMenu(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    switch (type) {
      case AppBarLayoutType.MeTiAc:
        return FixedMenu(
          height: 48,
          // showSubMenu: config.showSubMenu,
          showMenuSubItems: false,
          background: theme.colors.appBarPalette.background,
          foreground: theme.colors.appBarPalette.foreground,
          activeForeground: theme.colors.appBarPalette.selected,
          options: LegendRouter.of(context).menuOptions,
          activeBackground: theme.appBarPalette.background.lighten(),
          iconSize: theme.appBarSizing.iconSize,

          spacing: 0,
          collapse: true,
        );
      case AppBarLayoutType.TiMeAc:
        return FixedMenu(
          height: 48,
          // showSubMenu: config.showSubMenu,
          showMenuSubItems: false,
          background: theme.colors.appBarPalette.background,
          foreground: theme.colors.appBarPalette.foreground,
          activeForeground: theme.colors.appBarPalette.selected,
          options: LegendRouter.of(context).menuOptions,
          activeBackground: theme.appBarPalette.background.lighten(),
          iconSize: theme.appBarSizing.iconSize,
          spacing: theme.appBarSizing.spacing ?? 6,
        );
    }
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
          type: type,
          children: {
            if (showTitle)
              AppBarItem.TITLE: title ??
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getLogo(context),
                      LegendText(
                        text: LayoutProvider.of(context)!.title!,
                        textStyle: theme.typography.h6.copyWith(
                          color: theme.colors.appBarPalette.foreground,
                        ),
                      ),
                    ],
                  ),
            if (showMenu) AppBarItem.MENU: getMenu(context),
            if (actions != null) AppBarItem.ACTIONS: Builder(builder: actions!),
          },
        ),
      ),
    );
  }
}

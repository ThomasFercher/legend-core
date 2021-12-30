import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/fixed_appbar_colors.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/fixed_appbar_sizing.dart';
import 'package:legend_design_core/layout/fixed/menu/fixed_menu.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/router/routeInfoProvider.dart';
import 'package:legend_design_core/router/router_provider.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/theming/sizing/size_provider.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:legend_design_core/typography/typography.dart';

import 'package:provider/provider.dart';

class FixedAppBar extends StatelessWidget {
  final void Function(int i)? onActionPressed;
  final bool showSubMenu;
  final bool? showMenu;
  final WidgetBuilder? builder;
  final Widget? leading;
  final Radius? bottomBorderRadius;
  FixedAppBarSizing? sizing;
  FixedAppBarColors? colors;
  final BuildContext pcontext;
  final LayoutType? layoutType;

  FixedAppBar({
    this.showMenu,
    this.builder,
    this.leading,
    this.bottomBorderRadius,
    this.sizing,
    this.layoutType,
    required this.pcontext,
    this.onActionPressed,
    this.showSubMenu = true,
  });

  BoxDecoration? getCard() {
    return colors?.cardColor != null
        ? BoxDecoration(
            borderRadius: BorderRadius.all(sizing?.borderRadius ?? Radius.zero),
            color: colors?.cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1.6,
                blurRadius: 1.6,
              )
            ],
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    bool isSubRoute = true;
    bool showBackArrow = isSubRoute &&
        !(showMenu ?? true) &&
        layoutType == LayoutType.FixedHeader;
    sizing ??= theme.appBarSizing;
    colors ??= theme.appBarColors;

    return SliverAppBar(
      backgroundColor: colors?.backgroundColor,
      shape: sizing?.shape,
      leadingWidth: 0,
      leading: Container(
        width: 0,
      ),
      actions: [
        Container(
          width: 0,
        )
      ],
      title: Container(
        height: theme.appBarSizing.appBarHeight +
            (sizing?.contentPadding.vertical ?? 0.0),
        padding: EdgeInsets.only(
          left: sizing?.contentPadding.left ?? 0,
          right: sizing?.contentPadding.right ?? 0,
          top: sizing?.contentPadding.top ?? 0,
          bottom: sizing?.contentPadding.bottom ?? 0,
        ),
        child: Hero(
          tag: ValueKey('appBar'),
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (showBackArrow)
                          LegendAnimatedIcon(
                              icon: Icons.arrow_back_ios,
                              theme: LegendAnimtedIconTheme(
                                enabled: theme.colors.selectionColor,
                                disabled: theme.colors.appBarColors.foreground,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        if ((layoutType != LayoutType.FixedSider &&
                                layoutType != LayoutType.FixedHeaderSider) ||
                            SizeProvider.of(context).isMobile)
                          if (LayoutProvider.of(context)?.logo != null)
                            Container(
                              height: sizing?.titleSize ??
                                  sizing?.appBarHeight ??
                                  64,
                              width: sizing?.titleSize ??
                                  sizing?.appBarHeight ??
                                  64,
                              margin: EdgeInsets.only(
                                right: 12.0,
                              ),
                              child: Center(
                                child: LayoutProvider.of(context)!.logo,
                              ),
                            ),
                        if ((layoutType != LayoutType.FixedSider &&
                                layoutType != LayoutType.FixedHeaderSider) ||
                            SizeProvider.of(context).isMobile)
                          if (LayoutProvider.of(context)?.title != null)
                            Center(
                              child: LegendText(
                                text: LayoutProvider.of(context)!.title!,
                                textStyle: theme.typography.h6.copyWith(
                                  color: theme.colors.appBarColors.foreground,
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: SizeProvider.of(context)
                              .isMenuCollapsed(theme.menuWidth, theme) &&
                          !SizeProvider.of(context).isMobile
                      ? 96
                      : 16,
                  height: sizing?.appBarHeight,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (builder != null)
                          Container(
                            height: theme.appBarSizing.appBarHeight,
                            alignment: Alignment.center,
                            decoration: getCard(),
                            child: Builder(
                              builder: builder!,
                            ),
                          ),
                        if (onActionPressed != null)
                          LegendAnimatedIcon(
                            icon: Icons.settings,
                            theme: LegendAnimtedIconTheme(
                              enabled: theme.colors.selectionColor,
                              disabled: theme.appBarColors.foreground,
                            ),
                            onPressed: () {
                              onActionPressed!(0);
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                if (showMenu ?? true)
                  Container(
                    margin: EdgeInsets.only(
                      right: (sizing?.contentPadding.horizontal ?? 0),
                    ),
                    decoration: getCard(),
                    padding: EdgeInsets.symmetric(
                      horizontal: sizing?.borderRadius?.x ?? 0,
                    ),
                    child: FixedMenu(
                      context: context,
                      iconColor: theme.appBarColors.iconColor,
                      selected: theme.appBarColors.selectedColor,
                      backgroundColor: theme.appBarColors.backgroundColor,
                      foreground: theme.appBarColors.foreground,
                      showSubMenu: showSubMenu,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      titleSpacing: 0,
      toolbarHeight: theme.appBarSizing.appBarHeight +
          (sizing?.contentPadding.vertical ?? 0.0),
      expandedHeight: theme.appBarSizing.appBarHeight +
          (sizing?.contentPadding.vertical ?? 0.0),
      collapsedHeight: theme.appBarSizing.appBarHeight +
          (sizing?.contentPadding.vertical ?? 0.0),
      pinned: sizing?.pinned ?? false,
      snap: sizing?.floating ?? false,
      floating: sizing?.floating ?? false,
      elevation: 12.0,
      automaticallyImplyLeading: false,
    );
  }
}

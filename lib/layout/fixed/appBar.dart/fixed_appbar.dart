import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/fixed_appbar_colors.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/fixed_appbar_sizing.dart';
import 'package:legend_design_core/layout/fixed/menu/collapsed_menu.dart';
import 'package:legend_design_core/layout/fixed/menu/fixed_menu.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/router/routeInfoProvider.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/theming/sizing/size_provider.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:legend_design_core/utils/legend_utils.dart';
import 'package:provider/provider.dart';

class FixedAppBar extends StatefulWidget {
  final bool showSubMenu;
  final bool? showMenu;
  final WidgetBuilder? builder;
  final Widget? leading;
  final Radius? bottomBorderRadius;

  final LayoutType? layoutType;

  FixedAppBar({
    this.showMenu,
    this.builder,
    this.leading,
    this.bottomBorderRadius,
    this.layoutType,
    this.showSubMenu = true,
  });

  @override
  State<FixedAppBar> createState() => _FixedAppBarState();
}

class _FixedAppBarState extends State<FixedAppBar> {
  FixedAppBarColors? colors;
  FixedAppBarSizing? sizing;
  late bool menuCollapsed;
  late double lastX;
  late double lastW;

  bool fixedMenuPop = false;
  bool collapsedMenuPop = false;

  @override
  void initState() {
    super.initState();

    lastX = -1;
    lastW = -1;
    menuCollapsed = false;
  }

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

  void collapsedMenu(ThemeProvider theme, BuildContext context) {
    double width = SizeProvider.of(context).width / 2;
    double menuWidth = lastW / 2;
    double titleWidth =
        LegendUtils.getTitleIndent(theme.typography.h6, 'Legend Design');
    double icon = theme.appBarSizing.titleSize ?? 64;

    double horizontalPadding = theme.appBarSizing.contentPadding.left;
    bool showCollapsedMenu =
        width - menuWidth - titleWidth - icon - horizontalPadding < 0;

    if (showCollapsedMenu != menuCollapsed && !collapsedMenuPop) {
      setState(() {
        collapsedMenuPop = true;
        fixedMenuPop = false;
        menuCollapsed = showCollapsedMenu;
      });
    }
  }

  void fixedMenu(ThemeProvider theme, double x, double w, String title) {
    double icon = theme.appBarSizing.titleSize ?? 64;
    icon += theme.appBarSizing.contentPadding.left;
    double titleWidth = LegendUtils.getTitleIndent(theme.typography.h6, title);

    bool showFixedMenu = x >= titleWidth + icon;

    if (!showFixedMenu != menuCollapsed && !fixedMenuPop) {
      setState(() {
        fixedMenuPop = true;
        collapsedMenuPop = false;
        lastW = w;
        lastX = x;
        menuCollapsed = !showFixedMenu;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    sizing = theme.appBarSizing;
    colors = theme.appBarColors;
    bool isMobile = SizeProvider.of(context).isMobile;
    bool isSubRoute =
        RouteInfoProvider.getCurrentMenuOption(context)?.isUnderlying ?? false;
    bool showBackArrow = isSubRoute &&
        !(widget.showMenu ?? true) &&
        widget.layoutType == LayoutType.FixedHeader;

    if (menuCollapsed) {
      collapsedMenu(theme, context);
    }

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
                    padding: EdgeInsets.only(
                      left: sizing?.contentPadding.left ?? 0,
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
                        if ((widget.layoutType != LayoutType.FixedSider &&
                                widget.layoutType !=
                                    LayoutType.FixedHeaderSider) ||
                            isMobile)
                          if (LayoutProvider.of(context)?.logo != null)
                            Container(
                              width: sizing?.titleSize ?? 64,
                              height: sizing?.titleSize ?? 64,
                              margin: EdgeInsets.only(
                                right: 6,
                              ),
                              alignment: Alignment.centerRight,
                              child: LayoutProvider.of(context)!.logo,
                            ),
                        if ((widget.layoutType != LayoutType.FixedSider &&
                                widget.layoutType !=
                                    LayoutType.FixedHeaderSider) ||
                            isMobile)
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
                if (!menuCollapsed && (widget.showMenu ?? true))
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: getCard(),
                      padding: EdgeInsets.symmetric(
                        horizontal: sizing?.borderRadius?.x ?? 0,
                      ),
                      child: FixedMenu(
                        onPosChanged: (x, w) {
                          fixedMenu(
                              theme, x, w, LayoutProvider.of(context)!.title!);
                        },
                        iconColor: theme.appBarColors.iconColor,
                        selected: theme.appBarColors.selectedColor,
                        backgroundColor: theme.appBarColors.backgroundColor,
                        foreground: theme.appBarColors.foreground,
                        showSubMenu: widget.showSubMenu,
                      ),
                    ),
                  ),
                Positioned(
                  right: sizing?.contentPadding.right ?? 0,
                  height: sizing?.appBarHeight,
                  child: Row(
                    children: [
                      Container(
                        child: (widget.builder != null)
                            ? Container(
                                height: theme.appBarSizing.appBarHeight,
                                alignment: Alignment.center,
                                decoration: getCard(),
                                child: Builder(
                                  builder: widget.builder!,
                                ),
                              )
                            : null,
                      ),
                      if (menuCollapsed && (widget.showMenu ?? true))
                        Container(
                          margin: EdgeInsets.only(
                            left: sizing?.spacing ?? 8,
                          ),
                          decoration: getCard(),
                          child: CollapsedMenu(
                            width: 48,
                          ),
                        ),
                    ],
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

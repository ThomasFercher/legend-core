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
  final BuildContext context;
  final LayoutType? layoutType;
  late final bool collapsed;

  FixedAppBar({
    this.showMenu,
    this.builder,
    this.leading,
    this.bottomBorderRadius,
    this.layoutType,
    this.showSubMenu = true,
    required this.context,
  }) {
    ThemeProvider theme = context.watch<ThemeProvider>();
    double screenWidth = MediaQuery.of(context).size.width;
    double titleWidth = LegendUtils.getTitleIndent(
          theme.typography.h6,
          LayoutProvider.of(context)?.title ?? '',
        ) +
        (theme.appBarSizing.titleSize ?? 32) +
        (theme.appBarSizing.borderRadius?.x ?? 0) +
        theme.appBarSizing.contentPadding.left;

    collapsed = checkIfCollapsed(screenWidth, titleWidth);
  }

  bool checkIfCollapsed(double screenWidth, double titleWidth) {
    double split = screenWidth / 8192;
    double p = (titleWidth / screenWidth);
    double pW = screenWidth * p;

    double pP = 32 / screenWidth;
    double pw = screenWidth * pP;
    double flexP = pw / split;

    double rB = 48 / screenWidth;
    double rbw = screenWidth * rB;
    double flexRB = rbw / split;

    double flexTitle = pW / split;
    double rem = 8192 - flexTitle * 2;
    double rightident = rem / 2;

    if (rightident < flexTitle) {
      rightident = rem - flexTitle - flexP;
    }
    print('check');
    if (rightident > flexRB) {
      return false;
    } else {
      return true;
    }
  }

  @override
  State<FixedAppBar> createState() => _FixedAppBarState();
}

class _FixedAppBarState extends State<FixedAppBar> {
  FixedAppBarColors? colors;
  FixedAppBarSizing? sizing;

  late bool collapsed;

  @override
  void initState() {
    collapsed = widget.collapsed;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

  int getFlexMenu(double screenWidth, double titleWidth) {
    double split = screenWidth / 8192;
    double p = (titleWidth / screenWidth);
    double pW = screenWidth * p;

    double pP = 32 / screenWidth;
    double pw = screenWidth * pP;
    double flexP = pw / split;

    double rB = 48 / screenWidth;
    double rbw = screenWidth * rB;
    double flexRB = rbw / split;

    double flexTitle = pW / split;
    double rem = 8192 - flexTitle * 2;
    double rightident = rem / 2;

    if (rightident < flexTitle) {
      rightident = rem - flexTitle - flexP;
    }

    if (rightident < flexRB) {
      collapsed = true;
    }
    print('left');
    return rightident.ceil();
  }

  int getFlexTitle(double screenWidth, double titleWidth) {
    double split = screenWidth / 8192;
    double p = (titleWidth / screenWidth);
    double pW = screenWidth * p;

    double pP = 32 / screenWidth;
    double pw = screenWidth * pP;
    double flexP = pw / split;

    double flexTitle = pW / split;
    double rem = 8192 - 2 * flexTitle;
    double leftident = rem / 2;

    if (leftident < flexTitle + flexP) {
      leftident = flexTitle + flexP;
    }
    print('right');
    return leftident.ceil();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();
    sizing = theme.appBarSizing;
    colors = theme.appBarColors;

    bool isMobile = SizeProvider.of(context).isMobile;
    bool isSubRoute =
        RouteInfoProvider.getCurrentMenuOption(context)?.isUnderlying ?? false;
    bool showBackArrow = isSubRoute &&
        !(widget.showMenu ?? true) &&
        widget.layoutType == LayoutType.FixedHeader;

    double screenWidth = MediaQuery.of(context).size.width;
    double titleWidth =
        LegendUtils.getTitleIndent(theme.typography.h6, 'Legend Design') +
            (sizing?.titleSize ?? 32) +
            (sizing?.borderRadius?.x ?? 0) +
            (sizing?.contentPadding.left ?? 0);

    return Container(
      child: SliverAppBar(
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
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sizing?.contentPadding.left ?? 0,
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (showBackArrow)
                              LegendAnimatedIcon(
                                  icon: Icons.arrow_back_ios,
                                  theme: LegendAnimtedIconTheme(
                                    enabled: theme.colors.selectionColor,
                                    disabled:
                                        theme.colors.appBarColors.foreground,
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
                                      color:
                                          theme.colors.appBarColors.foreground,
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      ),
                      Row(
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
                          if (collapsed && (widget.showMenu ?? true))
                            Builder(builder: (context) {
                              collapsed = widget.checkIfCollapsed(
                                  screenWidth -
                                      (sizing?.contentPadding.left ?? 0),
                                  titleWidth);
                              return Container(
                                margin: EdgeInsets.only(
                                  left: sizing?.spacing ?? 8,
                                ),
                                decoration: getCard(),
                                child: CollapsedMenu(
                                  width: 48,
                                ),
                              );
                            }),
                        ],
                      ),
                    ],
                  ),
                  if (!collapsed)
                    Row(
                      children: [
                        Expanded(
                          flex: getFlexTitle(
                              screenWidth - (sizing?.contentPadding.left ?? 0),
                              titleWidth),
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: getCard(),
                          child: Opacity(
                            opacity: 1,
                            child: FixedMenu(
                              iconColor: theme.appBarColors.iconColor,
                              selected: theme.appBarColors.selectedColor,
                              backgroundColor:
                                  theme.appBarColors.backgroundColor,
                              foreground: theme.appBarColors.foreground,
                              showSubMenu: widget.showSubMenu,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: getFlexMenu(
                              screenWidth - (sizing?.contentPadding.left ?? 0),
                              titleWidth),
                          child: Container(
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
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
      ),
    );
  }
}

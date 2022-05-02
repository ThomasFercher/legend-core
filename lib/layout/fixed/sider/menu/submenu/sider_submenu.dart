import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/menu_option.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/src/provider.dart';

import '../../../menu/tiles/drawer_menu_tile.dart';
import 'sider_submenu_header.dart';

class SiderSubMenu extends StatefulWidget {
  final MenuOption option;
  final Color backgroundColor;
  final Color activeForeground;
  final Color activeBackground;
  final Color foregroundColor;
  final BorderRadius? borderRadius;
  final bool expanded;
  final void Function(bool val)? onResisize;
  final double headerHeight;
  final double itemHeight;
  final double iconSize;
  final double headerIconSize;
  final bool hasToPop;

  SiderSubMenu({
    required this.option,
    required this.activeBackground,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.activeForeground,
    required this.expanded,
    required this.headerHeight,
    required this.itemHeight,
    required this.iconSize,
    required this.headerIconSize,
    required this.hasToPop,
    this.onResisize,
    this.borderRadius,
  });

  @override
  State<SiderSubMenu> createState() => _SiderSubMenuState();
}

class _SiderSubMenuState extends State<SiderSubMenu> {
  late int selected;
  late int? hovered;
  late double contentHeight;
  late bool isExpanded;
  late List<Widget> tiles;

  @override
  void initState() {
    contentHeight = getMaxHeight();

    isExpanded = widget.expanded;
    tiles = [];
    selected = 0;
    hovered = null;
    super.initState();
  }

  double getMaxHeight() =>
      (widget.option.children?.length ?? 0) * widget.itemHeight;

  @override
  void didChangeDependencies() {
    MenuOption? sel = RouteInfoProvider.getCurrentMenuOption(context);

    selected = widget.option.children!.indexWhere((element) => element == sel);
    tiles = getTiles(context);
    super.didChangeDependencies();
  }

  /// This Method returns the whole menu.
  /// If a [MenuOption] has children, a [SiderSubMenu] is added, else
  /// we add a [DrawerMenuTile].
  List<DrawerMenuTile> getTiles(BuildContext context) {
    List<DrawerMenuTile> tiles = [];

    LegendTheme theme = context.watch<LegendTheme>();
    List<MenuOption> options = widget.option.children ?? [];
    for (int i = 0; i < options.length; i++) {
      final MenuOption option = options[i];

      tiles.add(
        DrawerMenuTile(
          foreground: widget.foregroundColor,
          selForeground: widget.activeForeground,
          background: widget.backgroundColor,
          selBackground: widget.activeBackground,
          isSelected: i == selected,
          isHovered: i == hovered,
          icon: option.icon,
          title: option.title,
          path: option.page,
          borderRadius: i == options.length - 1
              ? BorderRadius.vertical(
                  bottom: Radius.circular(theme.sizing.borderInset[0]),
                )
              : BorderRadius.zero,
          height: widget.itemHeight,
          textStyle: theme.typography.h1,
          iconSize: widget.iconSize,
          onHover: (value) {
            setState(() {
              hovered = value ? i : null;
            });
          },
          onClicked: () {
            setState(() {
              selected = i;
            });
            if (widget.hasToPop) {
              Navigator.of(context).pop();
            }
            LegendRouter.of(context)
                .pushPage(settings: RouteSettings(name: option.page));
          },
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();

    int headerIndex = widget.option.children?.length ?? 0;

    return LayoutBuilder(builder: (context, constraints) {
      contentHeight = getMaxHeight();
      final double maxHeight = contentHeight + widget.headerHeight;
      if (constraints.maxHeight < maxHeight) {
        contentHeight = constraints.maxHeight - widget.headerHeight;
      }

      return ClipRRect(
        borderRadius: widget.borderRadius ??
            BorderRadius.all(
              Radius.circular(
                theme.sizing.borderInset[0],
              ),
            ),
        child: Container(
          height: maxHeight,
          color: widget.backgroundColor,
          child: Column(
            children: [
              HeaderTile(
                option: widget.option,
                isExpanded: isExpanded,
                foreground: widget.foregroundColor,
                background: widget.backgroundColor,
                activeBackground: widget.activeBackground,
                activeForeground: widget.activeForeground,
                onExpanded: () {
                  isExpanded = !isExpanded;
                  if (widget.onResisize != null) {
                    widget.onResisize!(isExpanded);
                  }
                },
                onHover: (value) {
                  setState(() {
                    hovered = value ? headerIndex : null;
                  });
                },
                onClicked: () {
                  setState(() {
                    selected = headerIndex;
                  });

                  LegendRouter.of(context).pushPage(
                      settings: RouteSettings(
                    name: widget.option.page,
                  ));
                },
                height: widget.headerHeight,
                isHovered: headerIndex == hovered,
                isSelected: headerIndex == selected,
                iconSize: widget.headerIconSize,
              ),
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(
                    milliseconds: 200,
                  ),
                  curve: Curves.ease,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    addAutomaticKeepAlives: true,
                    clipBehavior: Clip.antiAlias,
                    children: getTiles(context),
                    //   shrinkWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

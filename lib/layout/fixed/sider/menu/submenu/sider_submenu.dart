import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/menu_option.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/src/provider.dart';

import 'sider_submenu_header.dart';

class SiderSubMenu extends StatefulWidget {
  final MenuOption option;
  final Color backgroundColor;
  final Color disabledBackground;
  final Color activeBackground;
  final Color foregroundColor;
  final Color subMenuColor;
  final bool alwaysExpanded;

  const SiderSubMenu({
    required this.option,
    required this.activeBackground,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.subMenuColor,
    required this.disabledBackground,
    required this.alwaysExpanded,
  });

  @override
  State<SiderSubMenu> createState() => _SiderSubMenuState();
}

class _SiderSubMenuState extends State<SiderSubMenu> {
  late double maxHeight;
  late bool isExpanded;
  late List<Widget> tiles;

  @override
  void initState() {
    bool alwaysExpanded = widget.alwaysExpanded;
    maxHeight = alwaysExpanded ? 320 : 0;
    isExpanded = alwaysExpanded;
    tiles = [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    tiles = getWidgets(context);
    super.didChangeDependencies();
  }

  List<Widget> getWidgets(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    MenuOption? sel = RouteInfoProvider.getCurrentMenuOption(context);
    return List.from(
      widget.option.children!.map(
        (MenuOption option) {
          return DrawerMenuTile(
            activeBackground: widget.activeBackground,
            icon: option.icon,
            title: option.title,
            path: option.page,
            backgroundColor: widget.backgroundColor,
            activeColor: theme.colors.selection,
            color: widget.foregroundColor.darken(0.05),
            textSize: theme.typography.h1.fontSize,
            forceColor: widget.option == sel,
            iconSize: 18,
          );
        },
      ),
    );
  }

  void onExit(PointerExitEvent e) {
    if (widget.alwaysExpanded) {
      return;
    } else if (isExpanded) {
      // Only closes if the user hovers upward.
      // With this we can avoid unwanted resizings of the menu.
      if (e.delta.dy < 0) {
        setState(() {
          maxHeight = 0;
          isExpanded = false;
        });
      }
    }
  }

  void onEnter(PointerEnterEvent e) {
    if (widget.alwaysExpanded) {
      return;
    } else if (!isExpanded) {
      setState(() {
        maxHeight = 320;
        isExpanded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();

    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      child: Column(
        children: [
          HeaderTile(
            background: widget.disabledBackground,
            activeBackground: widget.activeBackground,
            foreground: widget.foregroundColor,
            option: widget.option,
            isExpanded: isExpanded,
            expandedBackground: widget.backgroundColor,
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: theme.sizing.borderRadius[0].bottomLeft,
            ),
            child: AnimatedContainer(
              color: widget.backgroundColor,
              duration: Duration(
                milliseconds: 200,
              ),
              curve: Curves.easeInOutCubic,
              height: maxHeight,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: tiles,
              ),
            ),
          )
        ],
      ),
    );
  }
}

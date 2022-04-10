import 'package:flutter/material.dart';
import 'package:legend_design_core/objects/drawer_menu_tile.dart';
import 'package:legend_design_core/objects/menu_option.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/src/provider.dart';

import 'sider_submenu_header.dart';

class SiderSubMenu extends StatefulWidget {
  final MenuOption option;
  final Color backgroundColor;
  final Color disabledBackground;
  final bool collapsed;
  final Color activeBackground;
  final Color foregroundColor;
  final Color subMenuColor;

  const SiderSubMenu({
    required this.option,
    required this.activeBackground,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.subMenuColor,
    required this.disabledBackground,
    this.collapsed = false,
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
    maxHeight = 0;
    isExpanded = false;
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
            left: false,
            activeColor: theme.colors.selection,
            color: widget.foregroundColor.darken(0.05),
            collapsed: widget.collapsed,
            textSize: theme.typography.h1.fontSize,
            rectangleIndicator: true,
            forceColor: widget.option == sel,
            iconSize: 18,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(isExpanded);
    LegendTheme theme = context.watch<LegendTheme>();
    return MouseRegion(
      onEnter: (event) {
        if (!isExpanded) {
          setState(() {
            maxHeight = 320;
            isExpanded = true;
          });
        }
      },
      onExit: (e) {
        if (isExpanded) {
          // Only closes if the user hovers upward.
          // With this we can avoid unwanted resizings of the menu.
          if (e.delta.dy < 0) {
            setState(() {
              maxHeight = 0;
              isExpanded = false;
            });
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 8,
        ),
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
                  children: tiles,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

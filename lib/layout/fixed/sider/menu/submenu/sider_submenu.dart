import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/menu_option.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/src/provider.dart';

import 'sider_submenu_header.dart';

class SiderSubMenu extends StatefulWidget {
  final MenuOption option;
  final Color backgroundColor;
  final Color activeForeground;
  final Color activeBackground;
  final Color foregroundColor;
  final BorderRadius? borderRadius;
  final bool alwaysExpanded;

  SiderSubMenu({
    required this.option,
    required this.activeBackground,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.activeForeground,
    required this.alwaysExpanded,
    this.borderRadius,
  });

  @override
  State<SiderSubMenu> createState() => _SiderSubMenuState();
}

class _SiderSubMenuState extends State<SiderSubMenu> {
  late int selected;
  late int? hovered;
  late double maxHeight;
  late bool isExpanded;
  late List<Widget> tiles;

  @override
  void initState() {
    bool alwaysExpanded = widget.alwaysExpanded;
    maxHeight = alwaysExpanded ? 320 : 0;
    isExpanded = alwaysExpanded;
    tiles = [];
    selected = 0;
    hovered = null;
    super.initState();
  }

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
          borderRadius: widget.borderRadius,
          // height: widget.height,
          //  borderRadius: theme.sizing.borderRadius[0],
          onHover: (value) {
            setState(() {
              hovered = value ? i : null;
            });
          },
          onClicked: () {
            setState(() {
              selected = i;
            });
            LegendRouter.of(context)
                .pushPage(settings: RouteSettings(name: option.page));
          },
        ),
      );
    }

    return tiles;
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

    int headerIndex = widget.option.children?.length ?? 0;

    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      child: Column(
        children: [
          DrawerMenuTile(
            foreground: widget.foregroundColor,
            selForeground: widget.activeForeground,
            background: widget.backgroundColor,
            selBackground: widget.activeBackground,
            isSelected: headerIndex == selected,
            isHovered: headerIndex == hovered,
            icon: widget.option.icon,
            title: widget.option.title,
            path: widget.option.page,

            // height: widget.height,
            borderRadius: widget.borderRadius ??
                BorderRadius.vertical(
                  top: Radius.circular(
                    theme.sizing.borderInset[0],
                  ),
                ),
            onHover: (value) {
              setState(() {
                hovered = value ? headerIndex : null;
              });
            },
            onClicked: () {
              setState(() {
                selected = headerIndex;
              });
              LegendRouter.of(context)
                  .pushPage(settings: RouteSettings(name: widget.option.page));
            },
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
                children: getTiles(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}

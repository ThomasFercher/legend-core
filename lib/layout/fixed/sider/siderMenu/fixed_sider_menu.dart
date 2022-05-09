import 'package:flutter/material.dart';

import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/layout/fixed/sider/siderMenu/siderMenuStyle.dart';

import 'package:legend_design_core/layout/fixed/sider/siderMenu/submenu/sider_submenu.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:provider/src/provider.dart';

class FixedSiderMenu extends StatefulWidget {
  final bool showMenuSubItems;
  final bool subMenuExpanded;
  final bool collapsed;

  final List<MenuOption> options;

  final bool hasToPop;
  final SiderMenuStyle style;
  final SiderSubMenuStyle subMenuStyle;

  FixedSiderMenu({
    Key? key,
    required this.options,
    required this.showMenuSubItems,
    required this.collapsed,
    required this.subMenuStyle,
    required this.style,
    this.subMenuExpanded = true,
    this.hasToPop = false,
  }) : super(key: key);

  @override
  State<FixedSiderMenu> createState() => _FixedSiderMenuState();
}

class _FixedSiderMenuState extends State<FixedSiderMenu> {
  late int selected;
  late int? hovered;
  late Map<int, bool> expanded;
  late final SiderMenuStyle style;

  @override
  void initState() {
    style = widget.style;
    selected = 0;
    hovered = null;
    expanded = {};
    widget.subMenuExpanded;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MenuOption? sel = RouteInfoProvider.getCurrentMenuOption(context);
    selected = widget.options.indexWhere((element) => element == sel);
  }

  /// This Method returns the whole menu.
  /// If a [MenuOption] has children, a [SiderSubMenu] is added, else
  /// we add a [DrawerMenuTile].
  List<Widget> getTiles(BuildContext context) {
    List<Widget> tiles = [];

    MenuOption? sel = RouteInfoProvider.getCurrentMenuOption(context);

    LegendTheme theme = context.watch<LegendTheme>();

    for (int i = 0; i < widget.options.length; i++) {
      final MenuOption option = widget.options[i];
      if (option.children == null || !(widget.showMenuSubItems)) {
        tiles.add(
          DrawerMenuTile(
            disableRightPadding: true,
            spacing: 8,
            verticalPadding: style.padding.horizontal,
            horizontalPadding: style.padding.vertical,
            foreground: style.foreground,
            selForeground: style.activeForeground,
            background: style.background,
            selBackground: style.activeBackground,
            isSelected: option == sel,
            isHovered: i == hovered,
            icon: option.icon,
            height: style.itemHeight,
            iconSize: style.iconSize,
            title: widget.collapsed ? null : option.title,
            path: option.page,
            borderRadius: style.borderRadius ?? theme.sizing.borderRadius[0],
            onHover: (value) {
              setState(() {
                hovered = value ? i : null;
              });
            },
            onClicked: () {
              if (widget.hasToPop) {
                Navigator.of(context).pop();
              }
              LegendRouter.of(context).pushPage(
                settings: RouteSettings(name: option.page),
              );
            },
          ),
        );
      } else if (widget.showMenuSubItems) {
        tiles.add(
          SiderSubMenu(
            option: option,
            style: widget.subMenuStyle,
            hasToPop: widget.hasToPop,
            onResisize: (val) {
              setState(() {
                expanded.putIfAbsent(
                  i,
                  () => val,
                );
                expanded.update(i, (value) => val);
              });
            },
            expanded: false,
          ),
        );
      }
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = getTiles(context);
    List<SiderSubMenu> subMenus = List.of(tiles.whereType<SiderSubMenu>());
    List<int> indexes = subMenus.map((e) => tiles.indexOf(e)).toList();

    List<DrawerMenuTile> drawer_tiles =
        tiles.whereType<DrawerMenuTile>().toList();

    return Container(
      color: style.background,
      child: LayoutBuilder(builder: (context, snapshot) {
        double maxHeight = snapshot.maxHeight;
        double drawer_tiles_height = drawer_tiles.length * style.itemHeight;
        double spacing = style.spacing * (tiles.length);
        double remaining = maxHeight - drawer_tiles_height - spacing;

        for (var i = 0; i < indexes.length; i++) {
          int index = indexes[i];
          bool isExpanded = expanded[index] ?? false;

          if (isExpanded) {
            Widget child = tiles[index];

            tiles[index] = Container(
              constraints: BoxConstraints(maxHeight: remaining),
              child: child,
            );
          } else {
            Widget child = tiles[index];

            tiles[index] = Container(
              constraints: BoxConstraints(maxHeight: style.subMenuHeaderHeight),
              child: child,
            );
          }
        }

        return Container(
          height: maxHeight,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: tiles.traillingPaddingCol(style.spacing, last: true),
          ),
        );
      }),
    );
  }
}

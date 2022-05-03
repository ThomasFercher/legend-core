import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/submenu/sider_submenu.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/src/provider.dart';

class FixedSiderMenu extends StatefulWidget {
  final Color background;
  final Color foreground;
  final Color activeBackground;
  final Color activeForeground;
  final Color? subMenuColor;
  final bool showMenuSubItems;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final bool subMenuExpanded;
  final bool collapsed;
  final BorderRadius? borderRadius;
  final List<MenuOption> options;
  final double itemHeight;
  final double subMenuHeaderHeight;
  final double iconSize;
  final bool hasToPop;

  FixedSiderMenu({
    Key? key,
    required this.options,
    required this.background,
    required this.foreground,
    required this.activeBackground,
    required this.activeForeground,
    this.hasToPop = false,
    this.borderRadius,
    this.subMenuColor,
    this.padding = EdgeInsets.zero,
    required this.showMenuSubItems,
    this.subMenuExpanded = true,
    this.spacing = 12,
    this.itemHeight = 48,
    required this.collapsed,
    this.subMenuHeaderHeight = 52,
    this.iconSize = 24,
  }) : super(key: key);

  @override
  State<FixedSiderMenu> createState() => _FixedSiderMenuState();
}

class _FixedSiderMenuState extends State<FixedSiderMenu> {
  late int selected;
  late int? hovered;
  late Map<int, bool> expanded;

  @override
  void initState() {
    super.initState();

    selected = 0;
    hovered = null;
    expanded = {};
    widget.subMenuExpanded;
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
            horizontalPadding: 12,
            foreground: widget.foreground,
            selForeground: widget.activeForeground,
            background: widget.background,
            selBackground: widget.activeBackground,
            isSelected: option == sel,
            isHovered: i == hovered,
            icon: option.icon,
            height: widget.itemHeight,
            iconSize: widget.iconSize,
            title: widget.collapsed ? null : option.title,
            path: option.page,
            borderRadius: widget.borderRadius ?? theme.sizing.borderRadius[0],
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
            backgroundColor: (expanded[i] ?? false)
                ? theme.menuDrawerPalette.backgroundMenu
                : theme.menuDrawerPalette.background,
            activeBackground: theme.menuDrawerPalette.background_menu_selection,
            foregroundColor: theme.menuDrawerPalette.foreground,
            activeForeground: theme.menuDrawerPalette.foreground_menu_selction,
            expanded: expanded[i] ?? false,
            borderRadius: widget.borderRadius,
            headerHeight: widget.subMenuHeaderHeight,
            iconSize: widget.iconSize - 4,
            headerIconSize: widget.iconSize,
            itemHeight: widget.itemHeight - 12,
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
      color: widget.background,
      padding: widget.padding,
      child: LayoutBuilder(builder: (context, snapshot) {
        double maxHeight = snapshot.maxHeight;
        double drawer_tiles_height = drawer_tiles.length * widget.itemHeight;
        double spacing = widget.spacing * (tiles.length);
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
              constraints:
                  BoxConstraints(maxHeight: widget.subMenuHeaderHeight),
              child: child,
            );
          }
        }

        return Container(
          height: maxHeight,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: tiles.traillingPaddingCol(widget.spacing, last: true),
          ),
        );
      }),
    );
  }
}

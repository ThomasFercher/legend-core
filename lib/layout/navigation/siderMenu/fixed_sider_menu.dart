import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/siderMenuStyle.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/submenu/sider_submenu.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/route_info_provider.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class FixedSiderMenu extends StatefulWidget {
  final bool showMenuSubItems;
  final bool subMenuExpanded;
  final bool collapsed;

  final List<RouteDisplay> options;

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
    RouteDisplay? sel = RouteInfoProvider.getRouteDisplay(context);
    selected = widget.options.indexWhere((element) => element == sel);
  }

  /// This Method returns the whole menu.
  /// If a [RouteDisplay] has children, a [SiderSubMenu] is added, else
  /// we add a [DrawerMenuTile].
  List<Widget> getTiles(BuildContext context) {
    List<Widget> tiles = [];

    RouteDisplay? sel = RouteInfoProvider.getRouteDisplay(context);

    LegendTheme theme = context.watch<LegendTheme>();

    for (int i = 0; i < widget.options.length; i++) {
      final RouteDisplay option = widget.options[i];
      if (option.children == null || !(widget.showMenuSubItems)) {
        tiles.add(
          DrawerMenuTile(
            disableRightPadding: true,
            spacing: 8,
            verticalPadding: style.padding.vertical,
            horizontalPadding: style.padding.horizontal,
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
            path: option.route,
            borderRadius: style.borderRadius ?? theme.sizing.radius1.asRadius(),
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
                settings: RouteSettings(name: option.route),
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

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: tiles.traillingPaddingCol(style.spacing, last: true),
        );
      }),
    );
  }
}
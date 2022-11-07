import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/column/column_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/row/row_menu_tile.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/submenu/sider_submenu.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:legend_utils/functions/functions.dart';

class FixedSiderMenu extends StatefulWidget {
  final double width;
  final bool showMenuSubItems;
  final bool subMenuExpanded;
  final String? current;
  final int depth;
  final List<RouteInfo> options;
  final bool hasToPop;
  final SideMenuColorsStyle colors;
  final SideMenuSizingStyle sizing;
  final TextStyle textStyle;
  late final bool collapsed;

  FixedSiderMenu({
    super.key,
    required this.width,
    required this.options,
    required this.showMenuSubItems,
    required this.colors,
    required this.sizing,
    required this.textStyle,
    required this.depth,
    this.current,
    this.subMenuExpanded = true,
    this.hasToPop = false,
  }) {
    double biggestTitleWidth = 0;

    for (var i = 0; i < options.length; i++) {
      double titleWidth =
          LegendFunctions.getTitleIndent(textStyle, options[i].title);
      if (titleWidth > biggestTitleWidth) biggestTitleWidth = titleWidth;
    }

    if (width - biggestTitleWidth - sizing.iconSize - sizing.padding.vertical <
        0) {
      collapsed = true;
    } else {
      collapsed = false;
    }
  }

  @override
  State<FixedSiderMenu> createState() => _FixedSiderMenuState();
}

class _FixedSiderMenuState extends State<FixedSiderMenu> {
  late int? hovered;

  SideMenuColorsStyle get colors => widget.colors;
  SideMenuSizingStyle get sizing => widget.sizing;

  @override
  void initState() {
    hovered = null;
    super.initState();
  }

  /// This Method returns the whole menu.
  /// If a [RouteDisplay] has children, a [SiderSubMenu] is added, else
  /// we add a [RowMenuTile].
  List<Widget> getTiles(BuildContext context) {
    List<Widget> tiles = [];
    final current = widget.current;

    for (int i = 0; i < widget.options.length; i++) {
      final option = widget.options[i];
      final selected = i == hovered || current == option.name;

      if (option.children == null || !(widget.showMenuSubItems)) {
        tiles.add(
          ColumnMenuTile(
            background: selected ? colors.activeBackground : colors.background,
            foreground: selected ? colors.activeForeground : colors.foreground,
            title: widget.collapsed ? null : option.title,
            icon: option.icon,
            padding: widget.collapsed ? EdgeInsets.zero : sizing.padding,
            borderRadius: sizing.borderRadius,
            height: sizing.itemHeight,
            iconSize: sizing.iconSize,
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
                settings: RouteSettings(name: option.name),
              );
            },
          ),
        );
      } else if (widget.showMenuSubItems) {
        tiles.add(
          SiderSubMenu(
            current: current,
            option: option,
            sizing: sizing,
            colors: colors,
            hasToPop: widget.hasToPop,
            collapsed: widget.collapsed,
            expanded: false,
            onResisize: (_) => setState(() {}),
          ),
        );
      }
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = getTiles(context);

    return ColoredBox(
      color: colors.menuBackground,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: tiles.traillingPaddingCol(sizing.spacing, last: false),
      ),
    );
  }
}

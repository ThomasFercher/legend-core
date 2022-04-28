import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/menu/collapsed_menu.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/submenu/sider_submenu.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/provider.dart';

class FixedMenu extends StatefulWidget {
  final Color background;
  final Color foreground;
  final Color activeBackground;
  final Color activeForeground;
  final Color? subMenuColor;
  final bool showMenuSubItems;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final bool subMenuExpanded;
  final List<MenuOption> options;
  final double height;
  final double iconSize;

  FixedMenu({
    Key? key,
    required this.options,
    required this.background,
    required this.foreground,
    required this.activeBackground,
    required this.activeForeground,
    this.subMenuColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    required this.showMenuSubItems,
    this.subMenuExpanded = true,
    this.spacing = 12,
    required this.iconSize,
    required this.height,
  }) : super(key: key);

  @override
  State<FixedMenu> createState() => _FixedMenuState();
}

class _FixedMenuState extends State<FixedMenu> {
  late int selected;
  late int? hovered;

  @override
  void initState() {
    super.initState();

    selected = 0;
    hovered = null;
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
  List<DrawerMenuTile> getTiles(BuildContext context) {
    List<DrawerMenuTile> tiles = [];

    MenuOption? sel = RouteInfoProvider.getCurrentMenuOption(context);
    selected = widget.options.indexWhere((element) => element == sel);
    LegendTheme theme = context.watch<LegendTheme>();

    for (int i = 0; i < widget.options.length; i++) {
      final MenuOption option = widget.options[i];

      tiles.add(
        DrawerMenuTile(
          iconSize: widget.iconSize,
          foreground: widget.foreground,
          selForeground: widget.activeForeground,
          background: widget.background,
          selBackground: widget.activeBackground,
          isSelected: i == selected,
          isHovered: i == hovered,
          icon: option.icon,
          title: option.title,
          path: option.page,
          height: widget.height,
          borderRadius: theme.sizing.borderRadius[0],
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

  @override
  Widget build(BuildContext context) {
    List<DrawerMenuTile> tiles = getTiles(context);

    if (selected == -1) selected = 0;

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth == 32) {
        return CollapsedMenu(width: 32);
      } else {
        return Container(
          color: widget.background,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: tiles.traillingPaddingRow(widget.spacing),
          ),
        );
      }
    });
  }
}

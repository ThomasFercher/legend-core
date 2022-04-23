import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:legend_design_core/layout/drawers/sidermenu_vertical_tile.dart';
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
  final double? height;

  FixedSiderMenu({
    Key? key,
    required this.options,
    required this.background,
    required this.foreground,
    required this.activeBackground,
    required this.activeForeground,
    this.borderRadius,
    this.subMenuColor,
    this.padding = EdgeInsets.zero,
    required this.showMenuSubItems,
    this.subMenuExpanded = true,
    this.spacing = 12,
    this.height,
    required this.collapsed,
  }) : super(key: key);

  @override
  State<FixedSiderMenu> createState() => _FixedSiderMenuState();
}

class _FixedSiderMenuState extends State<FixedSiderMenu> {
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
            foreground: widget.foreground,
            selForeground: widget.activeForeground,
            background: widget.background,
            selBackground: widget.activeBackground,
            isSelected: i == selected,
            isHovered: i == hovered,
            icon: option.icon,
            title: widget.collapsed ? null : option.title,
            path: option.page,
            borderRadius: widget.borderRadius ?? theme.sizing.borderRadius[0],
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
      } else if (widget.showMenuSubItems) {
        tiles.add(
          SiderSubMenu(
            option: option,
            backgroundColor: widget.activeBackground,
            activeBackground: widget.activeBackground.darken(0.05),
            foregroundColor: widget.foreground,
            activeForeground: widget.activeForeground,
            alwaysExpanded: widget.subMenuExpanded,
            borderRadius: widget.borderRadius,
          ),
        );
      }
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = getTiles(context);

    return Container(
      color: widget.background,
      padding: widget.padding,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: tiles.traillingPaddingCol(widget.spacing),
      ),
    );
  }
}

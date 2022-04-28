import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/menu/collapsed_menu.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/submenu/sider_submenu.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:legend_design_core/utils/legend_utils.dart';
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

  final bool collapse;

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
    this.collapse = false,
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
      double spacing = 8;

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
          spacing: spacing,
          path: option.page,
          height: widget.height,
          borderRadius: widget.collapse
              ? BorderRadius.zero
              : theme.sizing.borderRadius[0],
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

  /// This Method returns the whole menu.
  /// If a [MenuOption] has children, a [SiderSubMenu] is added, else
  /// we add a [DrawerMenuTile].
  List<DrawerMenuTile> getTilesCollapsed(
      BuildContext context, double maxWidth) {
    List<DrawerMenuTile> tiles = [];

    MenuOption? sel = RouteInfoProvider.getCurrentMenuOption(context);
    selected = widget.options.indexWhere((element) => element == sel);
    LegendTheme theme = context.watch<LegendTheme>();

    double spacing = 4;
    double hor_padding = 8;
    double ratio = 0;
    double w = 0;
    double f_w = 0;
    for (int i = 0; i < widget.options.length; i++) {
      final MenuOption option = widget.options[i];

      double textSize =
          LegendUtils.getTitleIndent(theme.typography.h2, option.title ?? '');

      double normalWidth = widget.iconSize + textSize;
      double fixedSize = spacing + hor_padding * 2 + 2;

      w += normalWidth;
      f_w += fixedSize;
    }
    ratio = (maxWidth - f_w) / w;

    if (ratio > 1) ratio = 1;

    for (int i = 0; i < widget.options.length; i++) {
      final MenuOption option = widget.options[i];

      double textSize =
          LegendUtils.getTitleIndent(theme.typography.h2, option.title ?? '');

      double col_textSize = textSize * ratio;
      double col_iconSize = widget.iconSize * ratio;
      double fixedSize = spacing + hor_padding * 2 + 2;
      tiles.add(
        DrawerMenuTile(
          width: col_iconSize + col_textSize + fixedSize,
          iconSize: col_iconSize,
          textWidth: col_textSize,
          foreground: widget.foreground,
          selForeground: widget.activeForeground,
          background: widget.background,
          selBackground: widget.activeBackground,
          collapsed: widget.collapse,
          isSelected: i == selected,
          isHovered: i == hovered,
          horizontalPadding: hor_padding,
          icon: option.icon,
          title: option.title,
          spacing: spacing,
          path: option.page,
          height: widget.height,
          borderRadius: widget.collapse
              ? BorderRadius.zero
              : theme.sizing.borderRadius[0],
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
    if (selected == -1) selected = 0;

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth == 32) {
        return CollapsedMenu(width: 32);
      } else {
        double? width;
        List<DrawerMenuTile> tiles;
        if (constraints.maxWidth != double.infinity && widget.collapse) {
          width = constraints.maxWidth;
          tiles = getTilesCollapsed(context, width);
        } else {
          tiles = getTiles(context);
        }
        return Container(
          color: widget.background,
          //     width: width,
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

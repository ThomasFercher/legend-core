import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/collapsed_menu.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:legend_utils/functions/functions.dart';
import 'package:provider/provider.dart';

class FixedMenu extends StatefulWidget {
  final Color background;
  final Color foreground;
  final Color activeBackground;
  final Color activeForeground;
  final Color? subMenuColor;
  final bool showMenuSubItems;
  final double spacing;
  final double itemSpacing;
  final EdgeInsetsGeometry padding;
  final bool subMenuExpanded;
  final List<RouteDisplay> options;
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
    this.itemSpacing = 6,
    required this.iconSize,
    required this.height,
    this.collapse = false,
  }) : super(key: key);

  @override
  State<FixedMenu> createState() => _FixedMenuState();
}

class _FixedMenuState extends State<FixedMenu> {
  int? hovered;

  @override
  void initState() {
    super.initState();
  }

  /// This Method returns the whole menu.
  /// If a [RouteDisplay] has children, a [SiderSubMenu] is added, else
  /// we add a [DrawerMenuTile].
  List<DrawerMenuTile> getTiles(
    BuildContext context,
    RouteDisplay? sel,
  ) {
    List<DrawerMenuTile> tiles = [];

    LegendTheme theme = context.watch<LegendTheme>();

    for (int i = 0; i < widget.options.length; i++) {
      final RouteDisplay option = widget.options[i];

      tiles.add(
        DrawerMenuTile(
          iconSize: widget.iconSize,
          foreground: widget.foreground,
          selForeground: widget.activeForeground,
          background: widget.background,
          selBackground: widget.activeBackground,
          isSelected: option == sel,
          isHovered: i == hovered,
          icon: option.icon,
          title: option.title,
          spacing: widget.itemSpacing,
          path: option.route,
          horizontalPadding: widget.padding.horizontal / 2,
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
            LegendRouter.of(context)
                .pushPage(settings: RouteSettings(name: option.route));
          },
        ),
      );
    }

    return tiles;
  }

  Map<double, double> getIndents(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    Map<double, double> indents = {};
    double width = 0;

    for (int i = 0; i < widget.options.length; i++) {
      final RouteDisplay option = widget.options[i];

      double textSize =
          LegendFunctions.getTitleIndent(theme.typography.h2, option.title);

      double normalWidth = widget.iconSize +
          textSize +
          widget.itemSpacing +
          widget.padding.horizontal;
      double fixedSize = widget.spacing;

      if (i == 0) {
        indents.update(
          normalWidth,
          (value) => value = 0,
          ifAbsent: () => width,
        );
        width += normalWidth + fixedSize;
        continue;
      }

      indents.update(
        normalWidth,
        (value) => value = width,
        ifAbsent: () => width,
      );

      width += normalWidth + fixedSize;
    }

    return indents;
  }

  /// This Method returns the whole menu.
  /// If a [RouteDisplay] has children, a [SiderSubMenu] is added, else
  /// we add a [DrawerMenuTile].
  List<DrawerMenuTile> getTilesCollapsed(
    BuildContext context,
    double maxWidth,
    RouteDisplay? sel,
  ) {
    List<DrawerMenuTile> tiles = [];

    LegendTheme theme = context.watch<LegendTheme>();

    double spacing = 4;
    double hor_padding = 8;
    double ratio = 0;
    double w = 0;
    double f_w = 0;
    for (int i = 0; i < widget.options.length; i++) {
      final RouteDisplay option = widget.options[i];

      double textSize =
          LegendFunctions.getTitleIndent(theme.typography.h2, option.title);

      double normalWidth = widget.iconSize + textSize;
      double fixedSize = spacing + hor_padding * 2 + 2;

      w += normalWidth;
      f_w += fixedSize;
    }
    ratio = (maxWidth - f_w) / w;

    if (ratio > 1) ratio = 1;

    for (int i = 0; i < widget.options.length; i++) {
      final RouteDisplay option = widget.options[i];

      double textSize =
          LegendFunctions.getTitleIndent(theme.typography.h2, option.title);

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
          isSelected: option == sel,
          isHovered: i == hovered,
          horizontalPadding: hor_padding,
          icon: option.icon,
          title: option.title,
          spacing: spacing,
          path: option.route,
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
            LegendRouter.of(context).pushPage(
                settings: RouteSettings(name: option.route), useKey: true);
          },
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    RouteDisplay? sel = LegendRouter.of(context).getCurrent();

    return LayoutBuilder(
      builder: (context, constraints) {
        Map<double, double> indents = getIndents(context);
        if (constraints.maxWidth == 32) {
          return CollapsedMenu(width: 32);
        } else {
          double? width;
          List<DrawerMenuTile> tiles;
          if (constraints.maxWidth != double.infinity && widget.collapse) {
            width = constraints.maxWidth;
            tiles = getTilesCollapsed(context, width, sel);
          } else {
            tiles = getTiles(
              context,
              sel,
            );
          }

          return Container(
            color: widget.background,
            height: widget.height,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: tiles.traillingPaddingRow(widget.spacing),
            ),
          );
        }
      },
    );
  }
}

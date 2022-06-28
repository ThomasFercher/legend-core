import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/collapsed_menu.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/row/row_menu_tile.dart';
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
  final EdgeInsetsGeometry itemPadding;
  final bool subMenuExpanded;
  final List<RouteDisplay> options;
  final double height;
  final double iconSize;
  final BorderRadiusGeometry borderRadius;

  const FixedMenu({
    Key? key,
    required this.options,
    required this.background,
    required this.foreground,
    required this.activeBackground,
    required this.activeForeground,
    this.subMenuColor,
    required this.showMenuSubItems,
    this.subMenuExpanded = true,
    required this.spacing,
    this.itemSpacing = 6,
    required this.itemPadding,
    required this.iconSize,
    required this.height,
    required this.borderRadius,
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

  List<RowMenuTile> getTiles(
    BuildContext context,
    RouteDisplay? sel,
  ) {
    List<RowMenuTile> tiles = [];
    String? currentRoute = LegendRouter.of(context).getCurrent()?.route;
    LegendTheme theme = context.watch<LegendTheme>();

    for (int i = 0; i < widget.options.length; i++) {
      final RouteDisplay option = widget.options[i];
      bool isSelected = i == hovered || option.route == currentRoute;

      tiles.add(
        RowMenuTile(
          iconSize: widget.iconSize,
          foreground: isSelected ? widget.activeForeground : widget.foreground,
          background: isSelected ? widget.activeBackground : widget.background,
          icon: option.icon,
          title: option.title,
          spacing: widget.itemSpacing,
          height: widget.height,
          padding: widget.itemPadding,
          borderRadius: widget.borderRadius,
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

  @override
  Widget build(BuildContext context) {
    RouteDisplay? sel = LegendRouter.of(context).getCurrent();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth == 32) {
          return CollapsedMenu(width: 32);
        } else {
          List<RowMenuTile> tiles = getTiles(
            context,
            sel,
          );
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

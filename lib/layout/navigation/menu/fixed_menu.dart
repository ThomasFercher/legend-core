import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/collapsed_menu.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/row/row_menu_tile.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/menu/menu_colors.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/menu/menu_sizing.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:legend_utils/functions/functions.dart';
import 'package:provider/provider.dart';

class FixedMenu extends StatefulWidget {
  final bool showMenuSubItems;

  final List<RouteDisplay> options;

  final MenuSizing sizing;
  final MenuColors colors;

  const FixedMenu({
    Key? key,
    required this.options,
    required this.colors,
    required this.sizing,
    required this.showMenuSubItems,
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

  MenuColors get colors => widget.colors;
  MenuSizing get sizing => widget.sizing;

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
          iconSize: sizing.iconSize,
          foreground: isSelected ? colors.activeForeground : colors.foreground,
          background: isSelected ? colors.activeBackground : colors.background,
          icon: option.icon,
          title: option.title,
          spacing: sizing.itemSpacing,
          height: sizing.height,
          padding: sizing.padding,
          borderRadius: sizing.borderRadius,
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
            color: colors.menuBackground,
            height: sizing.height,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: tiles.traillingPaddingRow(sizing.spacing),
            ),
          );
        }
      },
    );
  }
}

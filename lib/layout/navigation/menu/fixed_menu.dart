import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/collapsed_menu.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/row/row_menu_tile.dart';
import 'package:legend_design_core/modals/subMenu/legend_sub_menu.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/menu/menu_colors.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/menu/menu_sizing.dart';
import 'package:legend_router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_utils/extensions/extensions.dart';

typedef FixedMenuBuilder = Widget Function(
  BuildContext context,
  List<RouteInfo> menuRoutes,
  RouteInfo? current,
);

class FixedMenu extends StatefulWidget {
  final bool showMenuSubItems;

  final List<RouteInfo> options;
  late final List<GlobalKey> optionsKeys;
  final BoxDecoration collapsedMenuDecoration;

  final MenuSizing sizing;
  final MenuColors colors;

  FixedMenu({
    Key? key,
    required this.options,
    required this.colors,
    required this.sizing,
    required this.showMenuSubItems,
    this.collapsedMenuDecoration = const BoxDecoration(),
  }) : super(key: key) {
    optionsKeys = options
        .map((option) => GlobalKey(
              debugLabel: option.name,
            ))
        .toList();
  }

  @override
  State<FixedMenu> createState() => _FixedMenuState();
}

class _FixedMenuState extends State<FixedMenu> {
  int? hovered;

  late bool _subMenuShown;

  @override
  void initState() {
    _subMenuShown = false;
    super.initState();
  }

  MenuColors get colors => widget.colors;
  MenuSizing get sizing => widget.sizing;

  List<RowMenuTile> getTiles(
    BuildContext context,
    RouteInfo? sel,
  ) {
    List<RowMenuTile> tiles = [];
    final currentRoute = LegendRouter.of(context).current?.name;
    final theme = LegendTheme.of(context);

    for (int i = 0; i < widget.options.length; i++) {
      final option = widget.options[i];
      final isSelected = i == hovered || option.name == currentRoute;
      final subOptions = option.children?.toList() ?? [];
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
          border: sizing.border,
          shadow: sizing.shadow,
          key: widget.optionsKeys[i],
          onHover: (_isHovered) {
            setState(() {
              hovered = _isHovered ? i : null;
            });
            if (subOptions.isNotEmpty) {
              if (_isHovered && !_subMenuShown) {
                showSubMenu(
                  theme: theme,
                  options: subOptions,
                  current: currentRoute ?? '',
                  route: option,
                  key: widget.optionsKeys[i],
                );
              } else {
                setState(() {
                  hovered = i;
                });
              }
            }
          },
          onClicked: () {
            LegendRouter.of(context).pushPage(option.name);
          },
        ),
      );
    }

    return tiles;
  }

  void showSubMenu({
    required LegendTheme theme,
    required List<RouteInfo> options,
    required String current,
    required RouteInfo route,
    required GlobalKey key,
  }) {
    _subMenuShown = true;
    LegendSubMenu.show(
      context: context,
      theme: theme,
      key: key,
      menuWidth: 200,
      offsetY: theme.appBarSizing.appBarHeight,
      options: options,
      current: current,
      parentHeight: theme.appBarSizing.appBarHeight,
      onExit: (_) {
        if (_subMenuShown && mounted) {
          setState(() {
            hovered = null;
            _subMenuShown = false;
          });

          // TODO: Is called if FixedSiderMenu pushes a Sub Route which results in nothing happening
          Navigator.of(context).pop();
        }
      },
      onParentExit: (e, offset) {
        setState(() {
          hovered = null;
          _subMenuShown = false;
        });
        Navigator.of(context).pop();
      },
      onParentTap: () {
        _subMenuShown = false;
        Navigator.of(context).pop();
        LegendRouter.of(context).pushPage(
          route.name,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    RouteInfo? sel = LegendRouter.of(context).routerDelegate.current;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth == 48) {
          return CollapsedMenu(
            width: 48,
            decoration: widget.collapsedMenuDecoration,
          );
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

import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/column/column_menu_tile.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_router/legend_router.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:legend_design_core/state/legend_state.dart';

/// Represents the parent of a submenu
/// If not hovered over it will behave like all other Drawertiles
/// If hovered over it will expand and show the submenu and change its colors
class HeaderTile extends LegendWidget {
  HeaderTile({
    required this.sizing,
    required this.colors,
    required this.option,
    required this.onExpanded,
    required this.isHovered,
    required this.isSelected,
    required this.isExpanded,
    required this.collapsed,
    this.onClicked,
    this.onHover,
    this.current,
  });

  final SideMenuColors colors;
  final SideMenuSizing sizing;

  final RouteInfo option;
  final bool isSelected;
  final bool isHovered;
  final bool isExpanded;
  final bool collapsed;
  final void Function() onExpanded;
  final void Function()? onClicked;
  final void Function(bool val)? onHover;
  final String? current;

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    bool isCurrent = current == option.name;
    Color foreground = isSelected || isHovered || isCurrent
        ? colors.activeForeground
        : colors.foreground;
    Color background = isSelected || isHovered || isCurrent
        ? colors.activeBackground
        : colors.background;

    return ColumnMenuTile(
      foreground: foreground,
      background: background,
      // spacing: sizing.spacing,
      icon: option.icon,
      title: collapsed ? null : option.title,
      height: collapsed ? null : sizing.itemHeight,
      padding: collapsed
          ? EdgeInsets.symmetric(
              vertical: sizing.padding.vertical / 2,
            )
          : sizing.padding,
      trailling: Container(
        height: sizing.itemHeight,
        child: LegendAnimatedIcon(
          icon: isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
          theme: LegendAnimtedIconTheme(
            disabled: theme.colors.menuDrawer.foreground.lighten(),
            enabled: theme.colors.menuDrawer.foregroundMenuSelection,
          ),
          disableShadow: true,
          padding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          iconSize: sizing.iconSize,
          onPressed: () {
            onExpanded();
          },
        ),
      ),
      borderRadius: BorderRadius.vertical(top: sizing.borderRadius.topLeft),
      onHover: onHover,
      onClicked: onClicked,
      iconSize: sizing.iconSize,
    );
  }
}

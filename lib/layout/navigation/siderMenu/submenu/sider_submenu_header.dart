import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/column/column_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/row/row_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/siderMenuStyle.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:provider/provider.dart';

/// Represents the parent of a submenu
/// If not hovered over it will behave like all other Drawertiles
/// If hovered over it will expand and show the submenu and change its colors
class HeaderTile extends StatelessWidget {
  HeaderTile({
    required this.option,
    required this.onExpanded,
    required this.isHovered,
    required this.isSelected,
    required this.style,
    required this.isExpanded,
    required this.collapsed,
    this.onClicked,
    this.onHover,
    this.current,
  });

  final SiderSubMenuStyle style;
  final RouteDisplay option;
  final bool isSelected;
  final bool isHovered;
  final bool isExpanded;
  final bool collapsed;
  final void Function() onExpanded;
  final void Function()? onClicked;
  final void Function(bool val)? onHover;
  final String? current;

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    bool isCurrent = current == option.route;
    Color foreground = isSelected || isHovered || isCurrent
        ? style.activeForeground
        : style.foreground;
    Color background = isSelected || isHovered || isCurrent
        ? style.activeBackground
        : style.background;

    return ColumnMenuTile(
      foreground: foreground,
      background: background,
      spacing: style.spacing,
      icon: option.icon,
      title: collapsed ? null : option.title,
      height: collapsed ? null : style.headerHeight,
      padding: collapsed
          ? EdgeInsets.symmetric(
              vertical: style.itemPadding.vertical / 2,
            )
          : EdgeInsets.symmetric(
              horizontal: style.itemPadding.horizontal / 2,
            ),
      trailling: LegendAnimatedIcon(
        icon: isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
        theme: LegendAnimtedIconTheme(
          disabled: theme.colors.menuDrawer.foreground.lighten(),
          enabled: theme.colors.menuDrawer.foreground_menu_selction,
        ),
        iconSize: style.iconSize,
        onPressed: () {
          onExpanded();
        },
      ),
      borderRadius: style.borderRadius,
      onHover: onHover,
      onClicked: onClicked,
      iconSize: style.iconSize,
    );
  }
}

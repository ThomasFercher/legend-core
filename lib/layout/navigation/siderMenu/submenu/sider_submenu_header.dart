import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/siderMenuStyle.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
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
    this.onClicked,
    this.onHover,
  });

  final SiderSubMenuStyle style;

  final RouteDisplay option;

  final bool isSelected;
  final bool isHovered;
  final bool isExpanded;
  final void Function() onExpanded;
  final void Function()? onClicked;
  final void Function(bool val)? onHover;

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    return DrawerMenuTile(
      foreground: style.foreground,
      selForeground: style.activeForeground,
      background: style.background,
      selBackground: style.activeBackground,
      horizontalPadding: style.itemPadding.horizontal,
      spacing: style.spacing,
      verticalPadding: style.itemPadding.vertical,
      isSelected: isSelected,
      isHovered: isHovered,
      icon: option.icon,
      title: option.title,
      path: option.route,
      height: style.headerHeight,
      actions: [
        LegendAnimatedIcon(
          icon: isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
          theme: LegendAnimtedIconTheme(
            disabled: theme.colors.sider.foreground,
            enabled: theme.colors.selection,
          ),
          iconSize: theme.siderSizing.iconSize / 3 * 2,
          onPressed: () {
            onExpanded();
          },
        ),
      ],
      borderRadius: style.borderRadius ??
          BorderRadius.vertical(
            top: Radius.circular(
              theme.sizing.borderInset[0],
            ),
            bottom: isExpanded
                ? Radius.zero
                : Radius.circular(
                    theme.sizing.borderInset[0],
                  ),
          ),
      onHover: (value) {
        if (onHover != null) onHover!(value);
      },
      onClicked: () {
        if (onClicked != null) onClicked!();
      },
      iconSize: style.iconSize,
    );
  }
}

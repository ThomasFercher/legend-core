import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/menu_option.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/provider.dart';

/// Represents the parent of a submenu
/// If not hovered over it will behave like all other Drawertiles
/// If hovered over it will expand and show the submenu and change its colors
class HeaderTile extends StatelessWidget {
  HeaderTile({
    required this.option,
    required this.isExpanded,
    required this.foreground,
    required this.background,
    required this.activeBackground,
    required this.activeForeground,
    required this.onExpanded,
    required this.height,
    required this.isHovered,
    required this.isSelected,
    required this.iconSize,
    this.onClicked,
    this.onHover,
    this.borderRadius,
  });

  final MenuOption option;
  final Color foreground;
  final Color background;
  final Color activeBackground;
  final Color activeForeground;
  final bool isExpanded;
  final double height;
  final double iconSize;

  final bool isSelected;
  final bool isHovered;
  final BorderRadius? borderRadius;
  final void Function() onExpanded;
  final void Function()? onClicked;
  final void Function(bool val)? onHover;

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    return DrawerMenuTile(
      foreground: foreground,
      selForeground: activeForeground,
      background: background,
      selBackground: activeBackground,
      isSelected: isSelected,
      isHovered: isHovered,
      icon: option.icon,
      title: option.title,
      path: option.page,
      height: height,
      actions: [
        LegendAnimatedIcon(
          icon: isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
          theme: LegendAnimtedIconTheme(
            disabled: theme.colors.siderPalette.foreground,
            enabled: theme.colors.selection,
          ),
          iconSize: theme.siderSizing.iconSize / 3 * 2,
          onPressed: () {
            onExpanded();
          },
        ),
      ],
      borderRadius: borderRadius ??
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
      iconSize: iconSize,
    );
  }
}

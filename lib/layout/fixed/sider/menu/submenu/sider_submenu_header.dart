import 'package:flutter/material.dart';
import 'package:legend_design_core/objects/drawer_menu_tile.dart';
import 'package:legend_design_core/objects/menu_option.dart';
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
    required this.expandedBackground,
  });

  final MenuOption option;
  final Color foreground;
  final Color background;
  final Color activeBackground;
  final Color expandedBackground;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    return DrawerMenuTile(
      activeBackground: activeBackground,
      icon: option.icon,
      title: option.title,
      path: option.page,
      backgroundColor: isExpanded ? expandedBackground : background,
      left: false,
      forceBackground: isExpanded,
      activeColor: theme.colors.selection,
      color: foreground,
      collapsed: false,
      bottomSpacing: 12,
      borderRadius: BorderRadius.vertical(
        top: theme.sizing.borderRadius[0].bottomLeft,
        bottom:
            isExpanded ? Radius.zero : theme.sizing.borderRadius[0].bottomLeft,
      ),
    );
  }
}

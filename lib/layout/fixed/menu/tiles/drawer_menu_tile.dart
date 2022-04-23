import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/utils/legend_utils.dart';
import 'package:provider/src/provider.dart';

import '../../../../typography/legend_text.dart';

const Duration duration = Duration(milliseconds: 200);

class DrawerMenuTile extends StatelessWidget {
  // Colors
  final Color foreground;
  final Color selForeground;
  final Color background;
  final Color selBackground;

  //Content
  final IconData? icon;
  final String? title;
  final String path;

  final double? height;

  final double iconSize;

  final BorderRadiusGeometry? borderRadius;

  final void Function()? onClicked;
  final void Function(bool value)? onHover;

  final bool isSelected;
  final bool isHovered;

  late final Color _foreground;
  late final Color _background;

  final double horizontalPadding;
  final double verticalPadding;
  final double spacing;

  final bool disableRightPadding;

  DrawerMenuTile({
    required this.foreground,
    required this.selForeground,
    required this.background,
    required this.selBackground,
    required this.path,
    required this.isHovered,
    required this.isSelected,
    this.title,
    this.icon,
    this.iconSize = 24,
    this.verticalPadding = 12,
    this.horizontalPadding = 24,
    this.spacing = 12,
    this.borderRadius,
    this.height,
    this.onClicked,
    this.onHover,
    this.disableRightPadding = false,
  }) {
    _background = (isHovered || isSelected) ? selBackground : background;
    _foreground = (isHovered || isSelected) ? selForeground : foreground;
  }

  double getWidth(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    return iconSize +
        spacing +
        horizontalPadding * 2 +
        LegendUtils.getTitleIndent(theme.typography.h2, title ?? '') +
        2;
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();

    return ClipRRect(
      borderRadius:
          borderRadius?.resolve(TextDirection.ltr) ?? BorderRadius.zero,
      child: InkWell(
        hoverColor: Colors.transparent,
        enableFeedback: true,
        onHover: (v) {
          if (onHover != null) onHover!(v);
        },
        onTap: () {
          if (onClicked != null) onClicked!();
        },
        child: AnimatedContainer(
          height: height,
          duration: duration,
          color: _background,
          padding: EdgeInsets.only(
            top: verticalPadding,
            bottom: verticalPadding,
            left: horizontalPadding,
            right: disableRightPadding ? 0 : horizontalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: iconSize,
                child: Icon(
                  icon,
                  color: _foreground,
                  size: iconSize,
                ),
              ),
              Container(
                width: spacing,
              ),
              if (title != null)
                SizedBox(
                  width:
                      LegendUtils.getTitleIndent(theme.typography.h2, title!) +
                          2,
                  child: LegendText(
                    padding: EdgeInsets.zero,
                    text: title,
                    selectable: false,
                    textStyle: theme.typography.h2.copyWith(
                      color: _foreground,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

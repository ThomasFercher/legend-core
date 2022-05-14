import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/legend_text.dart';
import 'package:legend_utils/functions/functions.dart';
import 'package:provider/src/provider.dart';

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
  final List<Widget>? actions;

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
  final TextStyle? textStyle;

  final double? width;

  final bool collapsed;

  final double? textWidth;

  DrawerMenuTile({
    required this.foreground,
    required this.selForeground,
    required this.background,
    required this.selBackground,
    required this.path,
    required this.isHovered,
    required this.isSelected,
    required this.iconSize,
    this.verticalPadding = 6,
    this.collapsed = false,
    this.width,
    this.spacing = 2,
    this.actions,
    this.textStyle,
    this.title,
    this.icon,
    this.horizontalPadding = 12,
    this.borderRadius,
    this.height,
    this.onClicked,
    this.onHover,
    this.disableRightPadding = false,
    this.textWidth,
  }) {
    _background = (isHovered || isSelected) ? selBackground : background;
    _foreground = (isHovered || isSelected) ? selForeground : foreground;
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();

    double textSize =
        LegendFunctions.getTitleIndent(theme.typography.h2, title ?? '');

    return SizedBox(
      width: width,
      child: LegendDetector(
        background: background,
        borderRadius:
            borderRadius?.resolve(TextDirection.ltr) ?? BorderRadius.zero,
        padding: EdgeInsets.zero,
        onHover: (v) {
          if (onHover != null) onHover!(v);
        },
        onTap: () {
          if (onClicked != null) onClicked!();
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: disableRightPadding ? 0 : horizontalPadding,
            top: verticalPadding,
            bottom: verticalPadding,
          ),
          child: Container(
            height: (height ?? verticalPadding * 2) - verticalPadding * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height,
                ),
                if (icon != null)
                  Container(
                    width: iconSize > 0 ? iconSize : 0,
                    child: Icon(
                      icon,
                      color: _foreground,
                      size: iconSize > 0 ? iconSize : 0,
                    ),
                    margin: EdgeInsets.only(right: spacing),
                  ),
                if (title != null)
                  Container(
                    width: textSize > 0 ? textSize : 0,
                    child: LegendText(
                      padding: EdgeInsets.zero,
                      text: title,
                      selectable: false,
                      dynamicSizing: collapsed,
                      textStyle: textStyle?.copyWith(color: _foreground) ??
                          theme.typography.h2.copyWith(
                            color: _foreground,
                          ),
                    ),
                  ),
                if (actions != null)
                  Expanded(
                    child: Container(),
                  ),
                if (actions != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

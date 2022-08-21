import 'package:flutter/material.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/state/legend_state.dart';

const Duration duration = Duration(milliseconds: 200);

class RowMenuTile extends LegendWidget {
  // Colors
  final Color foreground;
  final Color background;

  //Content
  final IconData? icon;
  final String? title;
  final Widget? trailling;

  final double? height;
  final double iconSize;
  final BorderRadiusGeometry? borderRadius;
  final double spacing;

  final void Function()? onClicked;
  final void Function(bool value)? onHover;

  final EdgeInsetsGeometry padding;

  final TextStyle? textStyle;

  RowMenuTile({
    required this.foreground,
    required this.background,
    required this.iconSize,
    super.key,
    this.trailling,
    this.textStyle,
    this.title,
    this.icon,
    this.borderRadius,
    this.height,
    this.onClicked,
    this.onHover,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    return SizedBox(
      height: height,
      child: LegendDetector(
        onHover: onHover,
        onTap: onClicked,
        child: Container(
          decoration: BoxDecoration(
            color: background,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: foreground,
                    size: iconSize,
                  ),
                if (title != null)
                  LegendText(
                    title,
                    padding: EdgeInsets.only(left: spacing),
                    selectable: false,
                    textStyle: textStyle?.copyWith(color: foreground) ??
                        theme.typography.h2.copyWith(
                          color: foreground,
                        ),
                  ),
                if (trailling != null) Expanded(child: Container()),
                if (trailling != null) trailling!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

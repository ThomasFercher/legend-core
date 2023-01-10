import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/gestures/ripple_detector.dart';
import 'package:legend_design_core/state/legend_state.dart';

class ColumnMenuTile extends LegendWidget {
  final String? title;
  final IconData? icon;
  final Widget? trailling;

  // Styling
  final Color background;
  final Color foreground;

  final EdgeInsetsGeometry? padding;
  final double spacing;
  final BorderRadius? borderRadius;
  final double? iconSize;
  final double? height;

  final void Function()? onClicked;
  final void Function(bool value)? onHover;

  const ColumnMenuTile({
    Key? key,
    required this.background,
    required this.foreground,
    this.padding,
    this.icon,
    this.title,
    this.trailling,
    this.onClicked,
    this.onHover,
    this.spacing = 8,
    this.borderRadius,
    this.iconSize,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    bool center = icon != null && title == null;

    return SizedBox(
      height: height,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        decoration: BoxDecoration(
          color: background,
          borderRadius: borderRadius,
        ),
        child: RippleDetector(
          onHover: onHover,
          onTap: onClicked,
          borderRadius: borderRadius,
          highlightColor: theme.colors.primary.withOpacity(0.6),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:
                  center ? MainAxisAlignment.center : MainAxisAlignment.start,
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
                    style: theme.typography.h1.copyWith(
                      color: foreground,
                    ),
                    selectable: false,
                  ),
                const Spacer(),
                if (trailling != null && title != null) trailling!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

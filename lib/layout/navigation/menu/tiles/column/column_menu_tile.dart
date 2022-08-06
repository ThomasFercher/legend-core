import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/tile_style.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_utils/legend_utils.dart';

class ColumnMenuTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();

    bool center = icon != null && title == null;

    return SizedBox(
      height: height,
      child: LegendDetector(
        onHover: onHover,
        onTap: onClicked,
        padding: EdgeInsets.zero,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          decoration: BoxDecoration(
            color: background,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: center
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    if (icon != null)
                      Icon(
                        icon,
                        color: foreground,
                        size: iconSize,
                      ),
                    if (title != null)
                      LegendText(
                        text: title,
                        padding: EdgeInsets.only(left: spacing),
                        textStyle: theme.typography.h1.copyWith(
                          color: foreground,
                        ),
                      ),
                    if (trailling != null && title != null)
                      Expanded(child: Container()),
                    if (trailling != null && title != null) trailling!,
                  ],
                ).expandIf(height != null),
                if (trailling != null && title == null)
                  Padding(
                    padding: EdgeInsets.only(top: spacing),
                    child: trailling!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

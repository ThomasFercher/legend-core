import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_utils/legend_utils.dart';

class TabOption extends StatefulWidget {
  const TabOption({
    Key? key,
    required this.background,
    required this.border,
    required this.height,
    required this.icon,
    required this.title,
    required this.selected,
    required this.selection,
    this.spacing = 6,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 4,
    ),
  }) : super(key: key);

  final Color background;
  final Color border;
  final Color selection;
  final double height;
  final String title;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final bool selected;

  @override
  State<TabOption> createState() => _TabOptionState();
}

class _TabOptionState extends State<TabOption> {
  late bool isHovered;

  @override
  void initState() {
    isHovered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    double iconSize = 24;
    double spacing = 4;
    double padding = 8;
    double textWidth =
        LegendFunctions.calcTextSize(widget.title, theme.typography.h1).width;
    double w = iconSize + textWidth + spacing + padding;

    return LegendDetector(
      onHover: (p0) {
        setState(() {
          isHovered = p0;
        });
      },
      child: Container(
        height: widget.height,
        padding: EdgeInsets.symmetric(horizontal: 4),
        width: w,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: theme.colors.primary,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  LegendText(
                    widget.title,
                    selectable: false,
                    style: theme.typography.h1.copyWith(
                      color: theme.colors.foreground1,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                height: 2,
                width: w,
                duration: Duration(milliseconds: 200),
                color: widget.selected
                    ? widget.selection
                    : isHovered
                        ? widget.selection
                        : widget.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

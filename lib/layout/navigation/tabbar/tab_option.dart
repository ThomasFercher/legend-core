import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/legend_text.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:provider/provider.dart';

class TabOption extends StatefulWidget {
  const TabOption({
    Key? key,
    required this.background,
    required this.border,
    required this.height,
    required this.icon,
    required this.title,
    required this.width,
    required this.selected,
    this.spacing = 6,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 4,
    ),
  }) : super(key: key);

  final Color background;
  final Color border;
  final double height;
  final String title;
  final IconData? icon;
  final double width;
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
    LegendTheme theme = context.watch<LegendTheme>();
    return LegendDetector(
      onHover: (p0) {
        setState(() {
          isHovered = p0;
        });
      },
      padding: EdgeInsets.zero,
      child: Container(
        height: widget.height,
        width: widget.width,
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
                    text: widget.title,
                    selectable: false,
                    textStyle: theme.typography.h1.copyWith(
                      color: theme.colors.foreground[0],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                height: 2,
                width: widget.width,
                duration: Duration(milliseconds: 200),
                color: widget.selected
                    ? theme.colors.selection
                    : isHovered
                        ? theme.colors.selection
                        : widget.background,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

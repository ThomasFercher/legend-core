import 'package:flutter/material.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/legend_text.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:provider/provider.dart';

class BottomBarItem extends StatelessWidget {
  final RouteDisplay option;
  final BottomBarSizing? sizing;
  final BottomBarPalette colors;
  final void Function(RouteDisplay option) onSelected;
  final bool isSelected;

  BottomBarItem({
    required this.option,
    required this.sizing,
    required this.colors,
    required this.onSelected,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  Widget getText(BuildContext context, Color color) {
    LegendTheme theme = context.watch<LegendTheme>();
    return LegendText(
      selectable: false,
      text: option.title,
      textStyle: theme.typography.h0.copyWith(
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? colors.activeColor : colors.disabledColor;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: LegendDetector(
        background: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(sizing?.height ?? 1 / 2),
        ),
        onTap: () {
          onSelected(option);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      option.icon,
                      size: sizing?.iconSize ?? 28,
                      color: color,
                    ),
                  ),
                  if ((sizing?.textAtBottom ?? false) &&
                      (sizing?.showText ?? true))
                    Container(
                      padding: EdgeInsets.only(top: 2.0),
                      child: getText(context, color),
                    ),
                ],
              ),
              if ((sizing?.showText ?? true) &&
                  (!(sizing?.textAtBottom ?? false)))
                Container(
                  padding: EdgeInsets.only(left: 4.0),
                  child: getText(context, color),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:provider/provider.dart';

class BottomBarItem extends StatelessWidget {
  final RouteDisplay option;
  final BottomBarSizingStyle sizing;
  final BottomBarColorsStyle colors;
  final void Function(RouteDisplay option) onSelected;
  final bool isSelected;
  final double width;

  BottomBarItem({
    required this.width,
    required this.option,
    required this.sizing,
    required this.colors,
    required this.onSelected,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? colors.activeColor : colors.disabledColor;
    LegendTheme theme = context.watch<LegendTheme>();

    return Container(
      width: width,
      height: sizing.height - sizing.padding.vertical,
      child: LegendDetector(
        background: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(sizing.height),
        ),
        onTap: () {
          onSelected(option);
        },
        child: Padding(
          padding: sizing.itemPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Icon(
                  option.icon,
                  size: sizing.iconSize,
                  color: color,
                ),
              ),
              if (sizing.showText)
                LegendText(
                  selectable: false,
                  text: option.title,
                  dynamicSizing: true,
                  textStyle: theme.typography.h0.copyWith(
                    color: color,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

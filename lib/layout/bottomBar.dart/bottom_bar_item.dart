import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_router/legend_router.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';

class BottomBarItem extends LegendWidget {
  final RouteInfo option;
  final void Function(RouteInfo option) onSelected;
  final bool isSelected;
  final double width;

  const BottomBarItem({
    required this.option,
    required this.onSelected,
    required this.isSelected,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final info = BottomBarInfo.of(context);
    final sizing = info.sizing;
    final colors = info.colors;
    final Color color = isSelected ? colors.activeColor : colors.disabledColor;
    final height = sizing.height - sizing.padding.vertical;
    return Container(
      width: width,
      height: height,
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
                  option.title,
                  selectable: false,
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

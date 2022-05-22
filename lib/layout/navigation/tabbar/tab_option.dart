import 'package:flutter/widgets.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_utils/legend_utils.dart';

class TabOption extends StatelessWidget {
  const TabOption({
    Key? key,
    required this.children,
    required this.background,
    required this.border,
    required this.height,
    this.spacing = 6,
    this.padding = const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 4,
    ),
  }) : super(key: key);

  final List<Widget> children;

  final Color background;
  final Color border;
  final double height;
  final EdgeInsetsGeometry padding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.all(
          Radius.circular(height),
        ),
        border: Border.all(
          color: border,
        ),
      ),
      child: Row(
        children: children.traillingPaddingRow(spacing),
      ),
    );
  }
}

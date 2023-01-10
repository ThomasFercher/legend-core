import 'package:legend_annotations/legend_annotations.dart';

part 'bottom_bar_layout.g.dart';

enum BottomBarSelectionType {
  whole,
  icon,
}

@LegendStyle(init: true)
class BottomBarLayoutStyle {
  final BottomBarSelectionType selectionType;

  const BottomBarLayoutStyle({
    required this.selectionType,
  });
}

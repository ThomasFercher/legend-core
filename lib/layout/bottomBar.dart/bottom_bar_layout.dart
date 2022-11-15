import 'package:legend_annotations/legend_annotations.dart';

part 'bottom_bar_layout.g.dart';

enum BottomBarSelectionType {
  whole,
  icon,
}

@legendCopy
class BottomBarLayout {
  final BottomBarSelectionType selectionType;

  const BottomBarLayout({
    required this.selectionType,
  });

  BottomBarLayout copyWith({
    BottomBarSelectionType? selectionType,
  }) =>
      _$copyWith(
        instance: this,
        selectionType: selectionType,
      );

  BottomBarLayout copyWithInstance(BottomBarLayout? instance) =>
      _$copyWithInstance(instance: this, copyInstance: instance);
}

enum BottomBarSelectionType {
  whole,
  icon,
}

class BottomBarLayout {
  final BottomBarSelectionType selectionType;

  const BottomBarLayout({
    required this.selectionType,
  });
}

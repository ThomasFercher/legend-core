class MenuDrawerSizing {
  final double width;
  final double iconSize;
  final double spacing;
  final double itemHeight;
  final double subMenuHeaderHeight;

  MenuDrawerSizing({
    this.width = -1,
    this.iconSize = -1,
    this.spacing = -1,
    this.itemHeight = -1,
    this.subMenuHeaderHeight = -1,
  });

  factory MenuDrawerSizing.from({
    required MenuDrawerSizing? sizing,
    required double width,
    required double iconSize,
    required double spacing,
    required double itemHeight,
    required double subMenuHeaderHeight,
  }) {
    if (sizing == null) {
      return MenuDrawerSizing(
        width: width,
        iconSize: iconSize,
        spacing: spacing,
        itemHeight: itemHeight,
        subMenuHeaderHeight: subMenuHeaderHeight,
      );
    } else {
      return MenuDrawerSizing(
        width: sizing.width == -1 ? width : sizing.width,
        iconSize: sizing.iconSize == -1 ? iconSize : sizing.iconSize,
        spacing: sizing.spacing == -1 ? spacing : sizing.spacing,
        itemHeight: sizing.itemHeight == -1 ? itemHeight : sizing.itemHeight,
        subMenuHeaderHeight: sizing.subMenuHeaderHeight == -1
            ? subMenuHeaderHeight
            : sizing.subMenuHeaderHeight,
      );
    }
  }
}

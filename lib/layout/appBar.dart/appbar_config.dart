class LegendAppBarConfig {
  final double appBarHeight;
  final double elevation;
  final bool pinned;
  final bool snap;
  final bool floating;
  final double horizontalPadding;
  final double actionSpaceing;
  final bool showSubMenu;
  final bool disableBackButton;
  final bool forceElevate;

  LegendAppBarConfig({
    required this.appBarHeight,
    required this.elevation,
    this.showSubMenu = true,
    this.floating = false,
    this.pinned = false,
    this.snap = false,
    this.horizontalPadding = 12,
    this.actionSpaceing = 8,
    this.disableBackButton = false,
    this.forceElevate = false,
  });
}

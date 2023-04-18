class AppBarProvider {
  final bool showMenu;
  final bool hideMenu;

  const AppBarProvider({
    this.showMenu = false,
    this.hideMenu = false,
  });

  AppBarProvider copyWith({
    bool? showMenu,
    bool? menuShownAfterAnimation,
    bool? hideMenu,
  }) {
    return AppBarProvider(
      showMenu: showMenu ?? this.showMenu,
      hideMenu: hideMenu ?? this.hideMenu,
    );
  }
}

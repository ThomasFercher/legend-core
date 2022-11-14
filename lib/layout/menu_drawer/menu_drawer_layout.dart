enum MenuDrawerLayoutType {
  drawerRight,
  drawerLeft,
  beneathAppBar,
}

class MenuDrawerLayout {
  final MenuDrawerLayoutType type;

  const MenuDrawerLayout({
    required this.type,
  });
}

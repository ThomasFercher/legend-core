import '../micros/sidemenu/sidemenu_sizing.dart';

class MenuDrawerSizingComponentsOverride {
  final SideMenuSizingOverride? sideMenuSizing;

  const MenuDrawerSizingComponentsOverride({
    this.sideMenuSizing,
  });
}

class MenuDrawerSizingComponents implements MenuDrawerSizingComponentsOverride {
  @override
  final SideMenuSizing sideMenuSizing;

  const MenuDrawerSizingComponents({
    required this.sideMenuSizing,
  });
}

import '../micros/menu/menu_sizing.dart';
import '../micros/sidemenu/sidemenu_sizing.dart';

class AppBarSizingComponentsOverride {
  final MenuSizingOverride? menuSizing;

  const AppBarSizingComponentsOverride({
    this.menuSizing,
  });
}

class AppBarSizingComponents implements AppBarSizingComponentsOverride {
  @override
  final MenuSizing menuSizing;

  const AppBarSizingComponents({
    required this.menuSizing,
  });
}

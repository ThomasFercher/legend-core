import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';

class SiderSizingComponentsOverride {
  final SideMenuSizingOverride? sideMenuSizing;

  const SiderSizingComponentsOverride({
    this.sideMenuSizing,
  });
}

class SiderSizingComponents implements SiderSizingComponentsOverride {
  @override
  final SideMenuSizing sideMenuSizing;

  const SiderSizingComponents({
    required this.sideMenuSizing,
  });
}

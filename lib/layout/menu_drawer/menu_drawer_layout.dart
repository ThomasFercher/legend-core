import 'package:legend_annotations/legend_annotations.dart';

part 'menu_drawer_layout.g.dart';

enum MenuDrawerLayoutType {
  drawerRight,
  drawerLeft,
  beneathAppBar,
}

@legendStyle
class MenuDrawerLayoutStyle {
  final MenuDrawerLayoutType type;

  const MenuDrawerLayoutStyle({
    required this.type,
  });
}

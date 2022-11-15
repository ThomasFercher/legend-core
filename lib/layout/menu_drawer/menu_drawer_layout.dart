import 'package:legend_annotations/legend_annotations.dart';

part 'menu_drawer_layout.g.dart';

enum MenuDrawerLayoutType {
  drawerRight,
  drawerLeft,
  beneathAppBar,
}

@legendCopy
class MenuDrawerLayout {
  final MenuDrawerLayoutType type;

  const MenuDrawerLayout({
    required this.type,
  });
  MenuDrawerLayout copyWithInstance(MenuDrawerLayout? instance) =>
      _$copyWithInstance(instance: this, copyInstance: instance);

  MenuDrawerLayout copyWith(
    MenuDrawerLayoutType type,
  ) =>
      _$copyWith(
        instance: this,
        type: type,
      );
}

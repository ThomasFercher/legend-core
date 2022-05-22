import '../appBar.dart/layout/appbar_layout.dart';

enum AppBarLayoutConfig { fixedAbove, body, none }

class AppBarLayout {
  final AppBarLayoutConfig layout;
  final AppBarLayoutType aligment;

  const AppBarLayout(this.layout, this.aligment);

  const AppBarLayout.none()
      : layout = AppBarLayoutConfig.none,
        aligment = AppBarLayoutType.MeTiAc;
}

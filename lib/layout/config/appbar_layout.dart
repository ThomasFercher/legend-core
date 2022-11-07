import '../appBar.dart/layout/appbar_layout.dart';

enum AppBarLayoutConfig {
  fixedAbove,
  body,
  none,
}

class AppBarLayout {
  final AppBarLayoutConfig layout;
  final AppBarLayoutType aligment;
  final bool showTabbar;

  const AppBarLayout({
    required this.layout,
    required this.aligment,
    this.showTabbar = false,
  });

  const AppBarLayout.none()
      : layout = AppBarLayoutConfig.none,
        aligment = AppBarLayoutType.MeTiAc,
        showTabbar = false;
}

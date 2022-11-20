import 'package:legend_annotations/legend_annotations.dart';
import 'layout/appbar_layout.dart';

part 'appbar_layout.g.dart';

enum AppBarLayoutType {
  TiMeAc,
  MeTiAc,
}

enum AppBarLayoutConfig {
  fixedAbove,
  body,
  none,
}

@LegendStyle()
abstract class AppBarLayoutStyle {
  final AppBarLayoutConfig layout;
  final AppBarLayoutType aligment;
  final bool showTabbar;

  const AppBarLayoutStyle({
    required this.layout,
    required this.aligment,
    this.showTabbar = false,
  });

  /*AppBarLayout copyWith({
    AppBarLayoutConfig? layout,
    AppBarLayoutType? aligment,
    bool? showTabbar,
  }) =>
      _$copyWith(
          instance: this,
          aligment: aligment,
          layout: layout,
          showTabbar: showTabbar);

  AppBarLayout copyWithInstance(AppBarLayout? instance) =>
      _$copyWithInstance(instance: this, copyInstance: instance);*/
}

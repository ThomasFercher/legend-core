import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';

import '../micros/sidemenu/sidemenu_colors.dart';

part 'sider_colors.g.dart';

@generateStyle
abstract class SiderColors {
  final Color background;
  final Color backgroundMenu;
  final Color foreground;
  final Color selection;

  late final SideMenuColors menuColors;

  SiderColors({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.selection,
    required this.menuColors,
  });
}

import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer_appbar.dart';

class AppBarProvider extends ChangeNotifier {
  bool showMenu;
  late bool menuShownAfterAnimation;
  bool hideMenu;

  AppBarProvider({
    this.showMenu = false,
    this.hideMenu = false,
  }) : menuShownAfterAnimation = showMenu;

  void toggle() async {
    showMenu = !showMenu;
    notifyListeners();

    await Future.delayed(duration);
    menuShownAfterAnimation = showMenu;
    notifyListeners();
  }

  void pop() {
    showMenu = false;
    hideMenu = true;
    notifyListeners();
  }
}

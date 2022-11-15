import 'package:flutter/material.dart';

class AppBarProvider extends ChangeNotifier {
  bool showMenu;

  bool hideMenu;

  AppBarProvider({
    this.showMenu = false,
    this.hideMenu = false,
  });

  void toggle() {
    showMenu = !showMenu;
    notifyListeners();
  }

  void pop() {
    showMenu = false;
    hideMenu = true;
    notifyListeners();
  }
}

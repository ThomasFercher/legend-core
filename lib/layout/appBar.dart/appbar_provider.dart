import 'package:flutter/material.dart';

class AppBarProvider extends ChangeNotifier {
  bool showMenu;

  AppBarProvider({
    this.showMenu = false,
  });

  void show(bool show) {
    showMenu = !showMenu;
    notifyListeners();
  }
}

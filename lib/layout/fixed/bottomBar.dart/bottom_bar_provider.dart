import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/menu_option.dart';

class BottomBarProvider with ChangeNotifier {
  late MenuOption selected;

  BottomBarProvider(
    this.selected,
  );

  void selectOption(MenuOption selectOption) {
    selected = selectOption;
    notifyListeners();
  }
}

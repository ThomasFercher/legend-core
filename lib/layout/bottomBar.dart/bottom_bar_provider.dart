import 'package:flutter/cupertino.dart';

class BottomBarProvider with ChangeNotifier {
  late int selectedIndex;

  BottomBarProvider({
    int first = 0,
  }) {
    selectedIndex = first;
  }

  set selected(int i) {
    selectedIndex = i;
    notifyListeners();
  }
}

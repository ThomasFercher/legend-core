import 'package:flutter/cupertino.dart';

import 'package:legend_router/router/routes/route_display.dart';

class BottomBarProvider with ChangeNotifier {
  late RouteDisplay selected;

  BottomBarProvider(
    this.selected,
  );

  void selectOption(RouteDisplay selectOption) {
    selected = selectOption;
    notifyListeners();
  }
}

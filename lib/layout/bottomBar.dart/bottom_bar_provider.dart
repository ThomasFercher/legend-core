import 'package:flutter/cupertino.dart';

import 'package:legend_router/router/routes/route_display.dart';

class BottomBarProvider with ChangeNotifier {
  final List<RouteDisplay> options;

  late int selectedIndex;

  BottomBarProvider({
    required this.options,
    required int first,
  }) {
    selectedIndex = first;
  }

  set selected(int i) {
    selectedIndex = i;
    notifyListeners();
  }
}

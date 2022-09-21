import 'package:flutter/cupertino.dart';
import 'package:legend_router/legend_router.dart';

class BottomBarProvider with ChangeNotifier {
  final List<RouteInfo> options;

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

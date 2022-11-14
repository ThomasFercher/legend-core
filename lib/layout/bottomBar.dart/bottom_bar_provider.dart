import 'package:flutter/cupertino.dart';
import 'package:legend_router/router/routes/route_info.dart';

class BottomBarProvider with ChangeNotifier {
  final List<RouteInfo> routes;
  late int selectedIndex;

  BottomBarProvider({
    this.selectedIndex = 1,
    required this.routes,
  });

  RouteInfo get current => routes[selectedIndex];

  set selected(int i) {
    selectedIndex = i;
    notifyListeners();
  }
}

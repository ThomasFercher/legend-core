import 'package:flutter/cupertino.dart';
import 'package:legend_router/legend_router.dart';

class BottomBarState {
  final List<RouteInfo> routes;
  late int selectedIndex;

  BottomBarState({
    this.selectedIndex = 1,
    required this.routes,
  });

  RouteInfo get current => routes[selectedIndex];

  set selected(int i) {
    selectedIndex = i;
  }

  BottomBarState copyWith({
    int? selectedIndex,
    List<RouteInfo>? routes,
  }) {
    return BottomBarState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      routes: routes ?? this.routes,
    );
  }
}

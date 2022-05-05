import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/router/route_info_provider.dart';

class LegendPage extends Page {
  final Widget child;
  final String name;
  final Object? arguments;

  LegendPage({
    required this.child,
    required this.name,
    this.arguments,
    LocalKey? key,
  }) : super(key: key, arguments: arguments, name: name);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return RouteInfoProvider(
          route: this,
          child: CupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            child: child,
            linearTransition: false,
          ),
        );
      },
    );
  }
}

class LegendModalPage extends Page {
  final Widget child;
  final String name;
  final Object? arguments;

  LegendModalPage({
    required this.child,
    required this.name,
    this.arguments,
    LocalKey? key,
  }) : super(key: key, arguments: arguments, name: name);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      opaque: false,
      barrierColor: Colors.black12,
      barrierDismissible: true,
      fullscreenDialog: true,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

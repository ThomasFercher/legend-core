import 'package:flutter/widgets.dart';

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
        return FadeTransition(
          opacity: animation,
          child: child,
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

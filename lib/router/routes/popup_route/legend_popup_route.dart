import 'package:flutter/material.dart';
import 'package:legend_design_core/router/routes/popup_route/popup_route_config.dart';
import 'package:legend_design_core/styles/theming/sizing/size_provider.dart';

const Duration duration = Duration(milliseconds: 200);

class LegendPopupRoute<T> extends PopupRoute<T> {
  final Widget widget;
  final PopupRouteConfig config;

  @override
  final RouteSettings settings;

  @override
  late final bool _barrierDismissible;

  LegendPopupRoute({
    required this.settings,
    required this.widget,
    required this.config,
    bool barrierDismissible = true,
  }) : super(settings: settings) {
    _barrierDismissible = barrierDismissible;
  }

  @override
  Color? get barrierColor => Colors.black12;

  @override
  bool get barrierDismissible => _barrierDismissible;

  @override
  String? get barrierLabel => 'test';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return SizeProvider(
      context: context,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      splits: [
        420,
      ],
      useMobilDesign: true,
      child: Stack(
        children: [
          Material(color: Colors.transparent, child: widget),
        ],
      ),
    );
  }

  Animation<double>? _animation;

  late Tween<Offset> _offsetTween;

  @override
  Animation<double> createAnimation() {
    assert(_animation == null);
    _animation = CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linearToEaseOut.flipped,
    );
    _offsetTween = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    );
    return _animation!;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Align(
      alignment: config.aligment,
      child: FractionalTranslation(
        translation: _offsetTween.evaluate(_animation!),
        child: child,
      ),
    );
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => duration;
}

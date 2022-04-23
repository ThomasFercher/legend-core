import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/provider.dart';

class SizeInfo extends InheritedWidget {
  @override
  final Widget child;
  final double width;
  final bool useMobilDesign;
  final double height;
  late bool _isMobile;
  final LegendSizingTheme sizing;

  SizeInfo({
    required this.child,
    required this.width,
    required this.height,
    required this.sizing,
    required this.useMobilDesign,
  }) : super(child: child) {
    _isMobile = _checkIsMobile;
    _updateSizing();
  }

  bool get isMobile => _isMobile;

  bool get _checkIsMobile {
    if (!kIsWeb ? Platform.isIOS || Platform.isAndroid : false) {
      return true;
    } else {
      return false;
    }
  }

  void _updateSizing() => sizing.setWidth = width;

  static SizeInfo of(BuildContext context) {
    final SizeInfo? result =
        context.dependOnInheritedWidgetOfExactType<SizeInfo>();
    assert(result != null, 'No SizeProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant SizeInfo oldWidget) {
    return oldWidget != this;
  }
}

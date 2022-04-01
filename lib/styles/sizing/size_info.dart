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
  final BuildContext context;

  final List<double> splits;

  SizeInfo({
    required this.child,
    required this.width,
    required this.height,
    required this.context,
    required this.useMobilDesign,
    required this.splits,
  }) : super(child: child) {
    _isMobile = _isMobileCheck();
    _updateSizing(context);
  }

  bool get isMobile => _isMobile;

  bool _isMobileCheck() {
    if (!kIsWeb ? Platform.isIOS || Platform.isAndroid : false) {
      return true;
    } else if (width < splits[0]) {
      return true;
    } else {
      return false;
    }
  }

  void _updateSizing(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    for (var i = 0; i < splits.length; i++) {
      double split = splits[i];
      double? splitB = i > 0 ? splits[i - 1] : null;

      if (width < split && width > (splitB ?? double.negativeInfinity)) {
        if (theme.sizingTheme.index != i) {
          print('Res: $split $i');
          theme.setSizing(i);
        }
      }
    }
  }

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

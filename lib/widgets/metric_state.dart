import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/provider/legend_provider.dart';
import 'package:legend_design_core/styles/theme_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';

class MetricReactor extends StatefulWidget {
  final Widget child;

  const MetricReactor({
    super.key,
    required this.child,
  });

  @override
  State<MetricReactor> createState() => _MetricReactorState();
}

class _MetricReactorState extends State<MetricReactor>
    with WidgetsBindingObserver {
  late SingletonFlutterWindow window;
  late MediaQueryData mediaQueryData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    window = WidgetsBinding.instance.window;
    mediaQueryData = MediaQueryData.fromWindow(window);
    Future.microtask(() => changeSizing());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    changeSizing();
    setState(() {
      window = WidgetsBinding.instance.window;
      mediaQueryData = MediaQueryData.fromWindow(window);
    });
  }

  void changeSizing() {
    ProviderWrapper.of<ThemeState>(context).update(
      (state) {
        final width = mediaQueryData.size.width;
        final sizingTheme = state.sizingTheme;
        final prev = sizingTheme.key;
        final next = sizingTheme.setWidth(width);

        if (prev != next) {
          Logger.log(
            'Sizing Theme changed from Key=$prev to Key=$next',
            'ThemeProvider',
          );

          return state.copyWith(
            theme: state.theme.copyWith(
              sizing: sizingTheme.sizing,
            ),
          );
        }
        return state;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQueryData,
      child: SizeInfo(
        window: window,
        child: widget.child,
      ),
    );
  }
}

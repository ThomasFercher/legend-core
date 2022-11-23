import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/styles/theme_provider.dart';
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
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      window = WidgetsBinding.instance.window;
      mediaQueryData = MediaQueryData.fromWindow(window);
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<ThemeProvider>().changeSize(mediaQueryData.size);
    return MediaQuery(
      data: mediaQueryData,
      child: SizeInfo(
        window: window,
        child: widget.child,
      ),
    );
  }
}

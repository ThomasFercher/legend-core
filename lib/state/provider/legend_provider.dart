import 'package:flutter/widgets.dart';

class LegendProvider<T> extends InheritedWidget {
  final T data;

  const LegendProvider({super.key, required super.child, required this.data});

  static T of<T>(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<LegendProvider<T>>();
    assert(result != null, 'No LegendProvider found in context');
    return result!.data;
  }

  // create maybeOf
  static T? maybeOf<T>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<LegendProvider<T>>()?.data;

  @override
  bool updateShouldNotify(LegendProvider<T> oldWidget) {
    return oldWidget.data != data;
  }
}

class ProviderWrapper<T> extends StatefulWidget {
  final Widget child;
  final T Function() builder;

  const ProviderWrapper({
    super.key,
    required this.child,
    required this.builder,
  });

  static ProviderWrapperState<T> of<T>(BuildContext context) {
    final result = context.findAncestorStateOfType<ProviderWrapperState<T>>()!;
    assert(result != null, 'No ProviderWrapperState found in context');
    return result;
  }

  @override
  State<ProviderWrapper<T>> createState() => ProviderWrapperState<T>();
}

class ProviderWrapperState<T> extends State<ProviderWrapper<T>> {
  late T data;

  @override
  void initState() {
    data = widget.builder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LegendProvider<T>(data: data, child: widget.child);
  }

  void change(T newdata) {
    setState(() {
      data = newdata;
    });
  }

  void update(T Function(T old) updater) {
    setState(() {
      data = updater(data);
    });
  }
}

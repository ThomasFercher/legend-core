import 'package:flutter/widgets.dart';

class LayoutProvider extends InheritedWidget {
  final Widget? globalFooter;
  final Widget Function(BuildContext context)? logoBuilder;
  final String? title;

  const LayoutProvider({
    required super.child,
    super.key,
    this.globalFooter,
    this.logoBuilder,
    this.title,
  });

  Widget getLogo(BuildContext context) {
    if (logoBuilder == null) return SizedBox.shrink();
    return logoBuilder!(context);
  }

  static LayoutProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LayoutProvider>()!;
  }

  @override
  bool updateShouldNotify(LayoutProvider oldWidget) {
    return true;
  }
}

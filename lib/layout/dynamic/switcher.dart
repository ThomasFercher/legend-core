import 'package:flutter/material.dart';

class LegendSwitcher extends StatelessWidget {
  final List<Widget> children;
  final List<double> splits;

  const LegendSwitcher({
    Key? key,
    required this.children,
    required this.splits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return children[getIndex(MediaQuery.of(context).size.width) ?? 0];
  }

  int? getIndex(double width) {
    for (var i = 0; i < splits.length; i++) {
      double split = splits[i];
      double? splitB = i > 0 ? splits[i - 1] : null;

      if (width < split && width > (splitB ?? double.negativeInfinity)) {
        return i;
      }
    }
    return null;
  }
}

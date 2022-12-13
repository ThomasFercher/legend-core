import 'package:flutter/widgets.dart';

abstract class HasHeight extends Widget {
  final double height;

  const HasHeight({
    required this.height,
  });
}

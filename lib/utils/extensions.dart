import 'package:flutter/cupertino.dart';

extension ExpandWidget on Widget {
  Widget expandIf(bool expand) {
    if (expand) {
      return Expanded(child: this);
    } else {
      return this;
    }
  }
}

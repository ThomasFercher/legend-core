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

extension HttpParameter on dynamic {
  String asHttpParameter(
    String s, {
    bool first = false,
  }) {
    return first ? '?$s=$this' : '&$s=$this';
  }
}

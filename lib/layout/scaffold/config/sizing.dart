import 'package:flutter/widgets.dart';

class ScaffoldSizing {
  final Size? appBarBottomSize;
  final double? maxContentWidth;
  final double? verticalChildrenSpacing;

  const ScaffoldSizing({
    this.appBarBottomSize,
    this.maxContentWidth,
    this.verticalChildrenSpacing,
  });

  factory ScaffoldSizing.copyWith(ScaffoldSizing base, ScaffoldSizing copy) {
    return ScaffoldSizing(
      appBarBottomSize: base.appBarBottomSize ?? copy.appBarBottomSize,
      maxContentWidth: base.maxContentWidth ?? copy.maxContentWidth,
      verticalChildrenSpacing:
          base.verticalChildrenSpacing ?? copy.verticalChildrenSpacing,
    );
  }
}

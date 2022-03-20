import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';

void main() {
  testWidgets('adds one to input values', (WidgetTester tester) async {
    await tester.pumpWidget(
      LegendScaffold(
        pageName: 'test',
        layoutType: LayoutType.FixedHeader,
        contentBuilder: (context, size) {
          return Container();
        },
      ),
    );
  });
}

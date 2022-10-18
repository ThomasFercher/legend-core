import 'package:flutter/widgets.dart';
import 'package:legend_design_core/styles/legend_theme.dart';

export 'package:legend_design_core/styles/legend_theme.dart';

abstract class LegendWidget extends LegendStatefulWidget {
  const LegendWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context, LegendTheme theme);

  @override
  _LegendState createState() => _LegendState();
}

class _LegendState extends LegendState<LegendWidget> {
  @override
  LegendTheme get theme => LegendTheme.of(context);

  @override
  Widget build(BuildContext context) {
    return widget.build(context, theme);
  }
}

abstract class LegendStatefulWidget extends StatefulWidget {
  const LegendStatefulWidget({Key? key}) : super(key: key);

  @override
  LegendState createState();

  @override
  StatefulElement createElement() {
    return StatefulElement(this);
  }
}

abstract class LegendState<T extends LegendStatefulWidget> extends State<T> {
  late final LegendTheme theme = LegendTheme.of(context);
}

import 'dart:ui';

abstract class LegendCustomField<T> {
  final String key;
  final T value;

  const LegendCustomField({
    required this.key,
    required this.value,
  });
}

class LegendCustomColorField extends LegendCustomField<Color> {
  const LegendCustomColorField({
    required super.value,
    required super.key,
  });
}

class LegendCustomDoubleField extends LegendCustomField<double> {
  const LegendCustomDoubleField({
    required super.value,
    required super.key,
  });
}

import 'dart:collection';

typedef ItemCreator<S> = S Function(Map<String, dynamic>);

class LegendParser<T> {
  final ItemCreator<T> creator;
  final List<dynamic> children;
  late final List<T> parsed;

  LegendParser(this.creator, this.children) {
    parsed = parse({});
  }

  List<T> parse(Map<String, Type> fields) {
    List<T> parsed = [];

    for (var child in children) {
      print(child.runtimeType);

      Map<String, dynamic> childMap = child as Map<String, dynamic>;

      parsed.add(
        creator(childMap),
      );
    }

    return parsed;
  }
}

import 'package:flutter/material.dart';
import 'package:legend_design_core/router/routes/section_info.dart';

import '../sections/section.dart';

class SectionNavigation extends InheritedWidget {
  SectionNavigation({
    Key? key,
    required this.onNavigate,
    required this.child,
    List<SectionInfo>? sections,
  }) : super(key: key, child: child) {
    this.sections = sections ?? [];
  }

  late final List<SectionInfo> sections;
  @override
  final Widget child;
  final void Function(SectionInfo section) onNavigate;

  void navigateToSection(SectionInfo section) {
    onNavigate(section);
  }

  static SectionNavigation? of(BuildContext context) {
    final SectionNavigation? result =
        context.dependOnInheritedWidgetOfExactType<SectionNavigation>();
    assert(result != null, 'No SizeProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SectionNavigation oldWidget) {
    return true;
  }

  static List<Widget> findSections(
    BuildContext context,
    List<Widget> children,
    List<SectionInfo> sections,
  ) {
    List<Widget> childs = [];

    for (final element in children) {
      Widget w;
      if (element is Section) {
        Section s = element;
        GlobalKey key = GlobalKey();

        SectionInfo se = sections.singleWhere(
          (element) => element.name == s.name,
          orElse: () {
            return sections.last;
          },
        );
        int i = sections.indexOf(se);
        sections[i] = SectionInfo(name: se.name, key: key);

        w = Container(
          key: key,
          child: s,
        );
      } else {
        w = element;
      }
      childs.add(w);
    }

    return childs;
  }
}

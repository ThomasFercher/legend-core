import 'package:legend_annotations/legend_annotations.dart';

part 'whether.g.dart';

extension Overwrite on bool {
  bool overWrite(bool copy) {
    return copy != this ? copy : this;
  }
}

@LegendStyle()
abstract class ScaffoldWhetherStyle {
  final bool showSiderMenu;
  final bool showSiderSubMenu;
  final bool showAppBarMenu;
  final bool showTopSubMenu;
  final bool showSiderChildMenu;
  final bool shareParentSiderMenu;
  final bool singlePage;
  final bool showBackButton;

  const ScaffoldWhetherStyle({
    this.showSiderMenu = false,
    this.showSiderSubMenu = false,
    this.showAppBarMenu = false,
    this.showTopSubMenu = false,
    this.showSiderChildMenu = false,
    this.shareParentSiderMenu = false,
    this.singlePage = false,
    this.showBackButton = true,
  });

  /* factory ScaffoldWhether.copyWith(ScaffoldWhether base, ScaffoldWhether copy) {
    return ScaffoldWhether(
      shareParentSiderMenu:
          base.shareParentSiderMenu.overWrite(copy.shareParentSiderMenu),
      showAppBarMenu: base.showAppBarMenu.overWrite(copy.showAppBarMenu),
      showSiderChildMenu:
          base.showSiderChildMenu.overWrite(copy.showSiderChildMenu),
      showSiderMenu: base.showSiderMenu.overWrite(copy.showSiderMenu),
      showSiderSubMenu: base.showSiderSubMenu.overWrite(copy.showSiderSubMenu),
      showTopSubMenu: base.showTopSubMenu.overWrite(copy.showTopSubMenu),
      singlePage: base.singlePage.overWrite(copy.singlePage),
      showBackButton: base.showBackButton.overWrite(copy.showBackButton),
    );
  }*/
}

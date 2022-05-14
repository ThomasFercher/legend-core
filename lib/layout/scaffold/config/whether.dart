extension Overwrite on bool {
  bool overWrite(bool copy) {
    return copy != this ? copy : this;
  }
}

class ScaffoldWhether {
  final bool showSiderMenu;
  final bool showSiderSubMenu;
  final bool showAppBarMenu;
  final bool showTopSubMenu;
  final bool showSiderChildMenu;
  final bool shareParentSiderMenu;
  final bool singlePage;

  const ScaffoldWhether({
    this.showSiderMenu = false,
    this.showSiderSubMenu = false,
    this.showAppBarMenu = false,
    this.showTopSubMenu = false,
    this.showSiderChildMenu = false,
    this.shareParentSiderMenu = false,
    this.singlePage = false,
  });

  factory ScaffoldWhether.copyWith(ScaffoldWhether base, ScaffoldWhether copy) {
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
    );
  }
}

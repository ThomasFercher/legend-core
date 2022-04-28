class ScaffoldWhether {
  final bool? disableContentDecoration;
  final bool? showContentHeader;
  final bool? showSiderMenu;
  final bool? showSiderSubMenu;
  final bool? showAppBarMenu;
  final bool? showSectionMenu;
  final bool? showTopSubMenu;
  final bool? showSiderChildMenu;
  final bool? shareParentSiderMenu;
  final bool? appBarForceElevate;
  final bool? enableDefaultSettings;
  final bool? singlePage;
  final bool? isUnderlyingRoute;

  const ScaffoldWhether({
    this.disableContentDecoration,
    this.showContentHeader,
    this.showSiderMenu,
    this.showSiderSubMenu,
    this.showAppBarMenu,
    this.showSectionMenu,
    this.showTopSubMenu,
    this.showSiderChildMenu,
    this.shareParentSiderMenu,
    this.appBarForceElevate,
    this.enableDefaultSettings,
    this.singlePage,
    this.isUnderlyingRoute,
  });

  factory ScaffoldWhether.copyWith(ScaffoldWhether base, ScaffoldWhether copy) {
    return ScaffoldWhether(
      appBarForceElevate: base.appBarForceElevate ?? copy.appBarForceElevate,
      disableContentDecoration:
          base.disableContentDecoration ?? copy.disableContentDecoration,
      enableDefaultSettings:
          base.enableDefaultSettings ?? copy.enableDefaultSettings,
      isUnderlyingRoute: base.isUnderlyingRoute ?? copy.isUnderlyingRoute,
      shareParentSiderMenu:
          base.shareParentSiderMenu ?? copy.shareParentSiderMenu,
      showAppBarMenu: base.showAppBarMenu ?? copy.showAppBarMenu,
      showContentHeader: base.showContentHeader ?? copy.showContentHeader,
      showSectionMenu: base.showSectionMenu ?? copy.showSectionMenu,
      showSiderChildMenu: base.showSiderChildMenu ?? copy.showSiderChildMenu,
      showSiderMenu: base.showSiderMenu ?? copy.showSiderMenu,
      showSiderSubMenu: base.showSiderSubMenu ?? copy.showSiderSubMenu,
      showTopSubMenu: base.showTopSubMenu ?? copy.showTopSubMenu,
      singlePage: base.singlePage ?? copy.singlePage,
    );
  }
}

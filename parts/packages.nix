{self, ...}: {
  perSystem = {pkgs, ...}: {
    packages = self.overlays.default pkgs pkgs;
  };
}

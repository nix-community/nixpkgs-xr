# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  flake-utils,
  nixpkgs,
  self,
  ...
}:
flake-utils.lib.eachDefaultSystem (
  system:
  let
    pkgs = import nixpkgs {
      overlays = [
        self.overlays.default
      ];
      inherit system;
    };

    inherit (pkgs) lib;

    inherit (lib)
      genAttrs
      filterAttrs
      isDerivation
      mapAttrs'
      nameValuePair
      ;

    packageAttributes = builtins.attrNames (self.overlays.default pkgs pkgs);

    workingPackages = filterAttrs (_: pkg: !pkg.meta.broken) self.packages.${system};
  in
  {
    packages = filterAttrs (
      _: pkg: isDerivation pkg && (lib.meta.availableOn pkgs.stdenv.hostPlatform pkg)
    ) (genAttrs packageAttributes (name: pkgs.${name}));
    checks = mapAttrs' (n: nameValuePair "package-${n}") workingPackages;
  }
)

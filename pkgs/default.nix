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
    pkgs = nixpkgs.legacyPackages.${system};
    inherit (pkgs) lib;

    inherit (lib)
      filterAttrs
      isDerivation
      makeScope
      mapAttrs'
      nameValuePair
      ;

    scope = makeScope pkgs.newScope (final: self.overlays.default (pkgs // final) pkgs);

    workingPackages = filterAttrs (_: pkg: !pkg.meta.broken) self.packages.${system};
  in
  {
    packages = filterAttrs (
      _: pkg: isDerivation pkg && (lib.meta.availableOn pkgs.stdenv.hostPlatform pkg)
    ) scope;
    checks = mapAttrs' (n: nameValuePair "package-${n}") workingPackages;
  }
)

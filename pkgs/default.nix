# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  lib,
  self,
  inputs,
  ...
}:
let
  inherit (lib)
    composeManyExtensions
    filterAttrs
    isDerivation
    makeScope
    ;
in
{
  # NOTE: Currying prev arg
  flake.overlays = {
    default = composeManyExtensions [
      (final: _: {
        xrSources = final.callPackage ../_sources/generated.nix { };
      })

      # New packaged added by us
      (import "${inputs.nixpkgs}/pkgs/top-level/by-name-overlay.nix" ./by-name)

      # Overridden packages
      (import ./overrides/envision-unwrapped.nix)
      (import ./overrides/monado.nix)
      (import ./overrides/opencomposite.nix)
      (import ./overrides/opencomposite-vendored.nix)
      (import ./overrides/wlx-overlay-s.nix)
    ];

    unstripped = throw "<nixpkgs-xr>.overlays.unstripped has been dropped, please define your own overlay for this.";
  };

  perSystem =
    { pkgs, ... }:
    {
      packages =
        let
          scope = makeScope pkgs.newScope (final: self.overlays.default (pkgs // final) pkgs);
        in
        filterAttrs (_: isDerivation) scope;
    };

}

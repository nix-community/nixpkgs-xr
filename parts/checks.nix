# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{ lib, ... }:
let
  inherit (builtins) attrValues;
  inherit (lib) mapAttrs' nameValuePair;
in
{
  perSystem =
    { pkgs, self', ... }:
    {
      checks =
        let
          packages = mapAttrs' (n: nameValuePair "package-${n}") self'.packages;
          devShells = mapAttrs' (n: nameValuePair "devShell-${n}") self'.devShells;
        in
        packages
        // devShells
        // {
          packages = pkgs.linkFarmFromDrvs "nixpkgs-xr-packages" (attrValues self'.packages);
        };
    };
}

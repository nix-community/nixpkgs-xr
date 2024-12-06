# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{ lib, ... }:
{
  perSystem =
    { config, pkgs, ... }:
    let
      inherit (lib) filterAttrs mapAttrs' nameValuePair;

      packages' = filterAttrs (
        _: pkg: !pkg.meta.broken && (lib.meta.availableOn pkgs.stdenv.hostPlatform pkg)
      ) config.packages;

      packageChecks = mapAttrs' (n: nameValuePair "package-${n}") packages';
      devShellChecks = mapAttrs' (n: nameValuePair "devShell-${n}") config.devShells;
    in
    {
      checks = packageChecks // devShellChecks;
    };
}

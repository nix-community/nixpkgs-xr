# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{lib, ...}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: let
    inherit (builtins) attrValues;
    inherit (lib) concatMapStringsSep;
  in {
    apps.genReadme.program = pkgs.writeShellApplication {
      name = "genReadme";
      text = ''
        cat ${pkgs.substituteAll {
          src = ../README-template.md;
          packageNames = concatMapStringsSep "\n" (pkg: "- `${pkg.pname}`") (attrValues self'.packages);
        }} > README.md
      '';
    };
  };
}

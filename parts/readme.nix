# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{ lib, ... }:
{
  perSystem =
    { pkgs, self', ... }:
    let
      inherit (builtins) attrNames;
      inherit (lib) concatMapStringsSep;
    in
    {
      apps.genReadme.program = pkgs.writeShellApplication {
        name = "genReadme";
        text = ''
          cat ${
            pkgs.substituteAll {
              src = ../README-template.md;
              packageNames = concatMapStringsSep "\n" (name: "- `${name}`") (attrNames self'.packages);
            }
          } > README.md
        '';
      };
    };
}

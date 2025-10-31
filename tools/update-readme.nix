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
      inherit system;
    };
    inherit (pkgs) lib;
  in
  {
    apps.update-readme = flake-utils.lib.mkApp {
      drv = pkgs.writeShellApplication {
        name = "update-readme";
        text = ''
          cat ${
            pkgs.replaceVars ../README-template.md {
              packageNames = lib.concatMapStringsSep "\n" (name: "- `${name}`") (
                builtins.attrNames self.packages.${system}
              );
            }
          } > README.md
        '';
      };
    };
  }
)

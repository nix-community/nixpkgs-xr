# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nvfetcher
          reuse
        ];
      };

      formatter = pkgs.nixfmt-rfc-style;
    };
}

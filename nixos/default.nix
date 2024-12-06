# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{ self, ... }:
{
  nixosModules.nixpkgs-xr =
    { config, lib, ... }:
    let
      inherit (lib)
        mkEnableOption
        mkIf
        mkOption
        ;
      cfg = config.nixpkgs.xr;
    in
    {
      options.nixpkgs.xr.enable = mkEnableOption "nixpkgs-xr overlay" // mkOption { default = true; };

      config = mkIf cfg.enable {
        nixpkgs.overlays = [
          self.overlays.default
        ];

        nix.settings = {
          substituters = [ "https://nix-community.cachix.org" ];
          trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
        };
      };
    };
}

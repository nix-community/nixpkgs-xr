# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

{self, ...}: {
  flake.nixosModules.nixpkgs-xr = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf mkOption optional;
    cfg = config.nixpkgs.xr;
  in {
    options.nixpkgs.xr = {
      enable = mkEnableOption "nixpkgs-xr overlay"
        // mkOption {default = true;};
      enableUnstripped = mkEnableOption "debug symbols for XR packages";
    };
    config = mkIf cfg.enable {
      nixpkgs.overlays =
        [self.overlays.default]
        ++ optional cfg.enableUnstripped self.overlays.unstripped;

      nix.settings = {
        substituters = ["https://nix-community.cachix.org"];
        trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
      };
    };
  };
}

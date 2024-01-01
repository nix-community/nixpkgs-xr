# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

{
  description = "Nixpkgs overlay for bleeding-edge XR/AR/VR packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      imports = [
        ./pkgs
      ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [nvfetcher reuse];
        };
      };
    };
}

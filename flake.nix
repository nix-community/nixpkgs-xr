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
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [nvfetcher reuse];
        };
      };
      flake.overlays.default = final: prev:
        let
          inherit (builtins) attrNames;
          inherit (nixpkgs.lib) genAttrs;

          sources = final.callPackage ./_sources/generated.nix {};
        in
          genAttrs (attrNames sources) (pkg: prev.${pkg}.overrideAttrs (_: sources.${pkg}));
    };
}

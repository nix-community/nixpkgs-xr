# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  description = "Nixpkgs overlay for bleeding-edge XR/AR/VR packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    nixpkgs,
    self,
  }: let
    systems = ["x86_64-linux" "aarch64-linux"];

    forSystem = system: fn: fn nixpkgs.legacyPackages.${system};
    forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: forSystem system fn);
  in {
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [nvfetcher reuse];
      };
    });

    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: self.overlays.default pkgs pkgs);

    overlays.default = final: prev: let
      sources = import ./_sources/generated.nix {
        inherit (final) fetchgit fetchurl fetchFromGitHub dockerTools;
      };

      mkOverride = pkg: newAttrs: prev.${pkg}.overrideAttrs (_: newAttrs);
    in
      final.lib.mapAttrs mkOverride sources;
  };
}

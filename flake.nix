# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  description = "Nixpkgs overlay for bleeding-edge XR/AR/VR packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, self }: let
    systems = [ "x86_64-linux" "aarch64-linux" ];

    forSystem = system: fn: fn nixpkgs.legacyPackages.${system};
    forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: forSystem system fn);

    mkSources = ps:
      import ./_sources/generated.nix {
        inherit (ps) fetchgit fetchurl fetchFromGitHub dockerTools;
      };

    mkPackageSet = sources: prev:
      nixpkgs.lib.genAttrs
      (builtins.attrNames sources)
      (pkg: prev.${pkg}.overrideAttrs (_: sources.${pkg}));
  in {
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [ nvfetcher reuse ];
      };
    });

    packages = forAllSystems (pkgs: mkPackageSet (mkSources pkgs) pkgs);

    overlays.default = final: prev: mkPackageSet (mkSources final) prev;
  };
}

# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  flake-utils,
  nixpkgs,
  self,
  treefmt-nix,
  nvfetcher,
  ...
}:
flake-utils.lib.eachDefaultSystem (
  system:
  let
    pkgs = nixpkgs.legacyPackages.${system};
    inherit (pkgs.lib) mapAttrs' nameValuePair;

    treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;

    devShellChecks = mapAttrs' (n: nameValuePair "devShell-${n}") self.devShells.${system};
  in
  {
    devShells.default = pkgs.mkShellNoCC {
      packages = [
        pkgs.git
        pkgs.reuse
        nvfetcher.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };

    checks = devShellChecks // {
      formatting = treefmtEval.config.build.check self;
    };

    formatter = treefmtEval.config.build.wrapper;
  }
)

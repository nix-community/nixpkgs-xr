# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{ inputs, ... }:
let
  inherit (builtins) mapAttrs;

  mkOverride = newAttrs: pkg: pkg.overrideAttrs (_: newAttrs);

  mkSources =
    final:
    import ../_sources/generated.nix {
      inherit (final)
        fetchgit
        fetchurl
        fetchFromGitHub
        dockerTools
        ;
    };

  mkSourceArgs = source: { inherit (source) pname version src; };

  mkCallPackage =
    final: cfg: source:
    final.callPackage cfg.drv (cfg.drvArgs source);

  mkSourceOverride = source: mkOverride (mkSourceArgs source);

  mkPackage =
    final: prev: sources: name: cfg:
    let
      source = sources.${name};
      pkg = if cfg ? drv then mkCallPackage final cfg source else prev.${name};
    in
    mkSourceOverride source pkg;

  mkDebugOverride =
    prev: pkg: _:
    mkOverride { dontStrip = true; } prev.${pkg};

  packages = {
    index_camera_passthrough = {
      drv = ../pkgs/index_camera_passthrough;
      drvArgs = source: {
        inherit (inputs) fenix;
        cargoLock = source.cargoLock."Cargo.lock";
      };
    };
    monado = { };
    opencomposite = { };
  };
in
{
  flake.overlays = {
    default = final: prev: mapAttrs (mkPackage final prev (mkSources final)) packages;
    unstripped = final: prev: mapAttrs (mkDebugOverride prev) packages;
  };
}

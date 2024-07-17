# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{ inputs, lib, ... }:
let
  inherit (builtins) mapAttrs;

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

  mkCallPackage =
    final: cfg: source:
    final.callPackage cfg.drv (cfg.drvArgs source);

  mkPackage =
    final: prev: sources: name: cfg:
    let
      source = sources.${name};
      pkg =
        if cfg ? drv then
          mkCallPackage final cfg source
        else
          prev.${name} or (throw "package ${name} not in Nixpkgs!");
      # final: prev: source: prevAttrs {<attrs>}
      extraAttrs =
        cfg.extraAttrs or (
          _: _: _: _:
          { }
        );
    in
    (pkg.overrideAttrs (_: { inherit (source) pname version src; })).overrideAttrs (
      extraAttrs final prev source
    );

  mkDebugOverride =
    prev: pkg: _:
    prev.${pkg}.overrideAttrs (_: { dontStrip = true; });

  packages = {
    index_camera_passthrough = {
      drv = ../pkgs/index_camera_passthrough;
      drvArgs = source: {
        inherit (inputs) fenix;
        cargoLock = source.cargoLock."Cargo.lock";
      };
    };
    monado = { };
    opencomposite = {
      extraAttrs = final: _: source: prevAttrs: {
        nativeBuildInputs = prevAttrs.nativeBuildInputs or [] ++ [
          # recent versions broke with Make
          final.ninja
        ];
        cmakeFlags = prevAttrs.cmakeFlags or [] ++ [
          (lib.cmakeFeature "CMAKE_CXX_FLAGS" "-Wno-error=format-security")
          # TODO: This is a temporary workaround to fix missing json headers. File bug upstream!
          (lib.cmakeBool "USE_SYSTEM_OPENXR" false)
          (lib.cmakeBool "USE_SYSTEM_GLM" false)
          (lib.cmakeFeature "OC_VERSION" "${source.src.rev} (${source.date})")
        ];
      };
    };
    wlx-overlay-s = {
      extraAttrs = final: _: source: _: {
        cargoDeps = final.rustPlatform.importCargoLock source.cargoLock."Cargo.lock";
      };
    };
  };
in
{
  flake.overlays = {
    default = final: prev: mapAttrs (mkPackage final prev (mkSources final)) packages;
    unstripped = final: prev: mapAttrs (mkDebugOverride prev) packages;
  };
}

{lib, ...}: let 
  inherit (builtins) attrNames;
  inherit (lib) genAttrs;

  mkSources = ps: import ../_sources/generated.nix {
    inherit (ps) fetchgit fetchurl fetchFromGitHub dockerTools;
  };

  mkPackageSet = sources: prev:
    genAttrs (attrNames sources) (pkg: prev.${pkg}.overrideAttrs (_: sources.${pkg}));

  overlay = final: mkPackageSet (mkSources final);
in {
  perSystem = {pkgs, ...}: {
    packages = mkPackageSet (mkSources pkgs) pkgs;
  };

  flake.overlays.default = overlay;
}

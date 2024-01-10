let
  inherit (builtins) mapAttrs;

  mkSources = final:
    import ../_sources/generated.nix {
      inherit (final) fetchgit fetchurl fetchFromGitHub dockerTools;
    };

  mkSourceOverride = prev: pkg: newAttrs: prev.${pkg}.overrideAttrs (_: newAttrs);

  mkDebugOverride = prev: pkg: _:
    prev.${pkg}.overrideAttrs (_: {
      dontStrip = true;
    });
in {
  flake.overlays = {
    default = final: prev: mapAttrs (mkSourceOverride prev) (mkSources final);
    unstripped = final: prev: mapAttrs (mkDebugOverride prev) (mkSources final);
  };
}

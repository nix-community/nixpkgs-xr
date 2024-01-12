{lib, ...}: let
  inherit (lib) mapAttrs' nameValuePair;
in {
  perSystem = {self', ...}: {
    checks = let
      packages = mapAttrs' (n: nameValuePair "package-${n}") self'.packages;
      devShells = mapAttrs' (n: nameValuePair "devShell-${n}") self'.devShells;
    in
      packages // devShells;
  };
}

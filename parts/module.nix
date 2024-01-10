{self, ...}: {
  flake.nixosModules.nixpkgs-xr = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf mkOption optional;
    cfg = config.nixpkgs.xr;
  in {
    options.nixpkgs.xr = {
      enable = mkEnableOption "nixpkgs-xr overlay"
        // mkOption {default = true;};
      enableUnstripped = mkEnableOption "debug symbols for XR packages";
    };
    config = mkIf cfg.enable {
      nixpkgs.overlays =
        [self.overlays.default]
        ++ optional cfg.enableDebug [self.overlays.unstripped];

      nix.settings = {
        substituters = ["https://nixpkgs-xr.cachix.org"];
        trusted-public-keys = ["nixpkgs-xr.cachix.org-1:MmpJFzgK51AitU+tunf3aDOSDb9dKXuRyqR+EF6Z5ws="];
      };
    };
  };
}

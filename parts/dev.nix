{
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [nvfetcher reuse];
    };

    formatter = pkgs.alejandra;
  };
}

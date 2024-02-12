# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2023 Naïm Favier <n@monade.li>
#
# SPDX-License-Identifier: MIT
{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nvfetcher
          reuse
        ];
      };

      formatter = pkgs.writeShellApplication {
        name = "nixpkgs-xr-format";

        runtimeInputs = [ pkgs.nixfmt-rfc-style ];
        text = ''
          nixfmt_args=()
          while [[ $# -gt 0 ]]; do
            case "$1" in
              .)
                # ignore "." parameter passed by nix fmt
                shift
                ;;
              -c|--check)
                nixfmt_args+=("$1")
                shift
                ;;
              *)
                echo "Unknown option $1" >&2
                exit 1
                ;;
            esac
          done

          git_root=$(git rev-parse --show-toplevel)

          git ls-files -z --cached --full-name -- ":!:_sources/" \
            | grep -z '\.nix$' \
            | sed -z "s|^|$git_root/|" \
            | xargs -0 nixfmt "$@"
        '';
      };
    };
}

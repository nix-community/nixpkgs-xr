# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2025 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{ nixpkgs, self, ... }:
let
  inherit (nixpkgs.lib) composeManyExtensions;
in
{
  overlays.default = composeManyExtensions [
    (final: _: {
      xrSources = final.callPackage ../_sources/generated.nix { };
      xrLib = self.lib;
    })

    # New packaged added by us
    (import "${nixpkgs}/pkgs/top-level/by-name-overlay.nix" ./by-name)

    # Overridden packages
    (import ./overrides/envision-unwrapped.nix)
    (import ./overrides/monado.nix)
    (import ./overrides/opencomposite.nix)
    (import ./overrides/opencomposite-vendored.nix)
    (import ./overrides/oscavmgr.nix)
    (import ./overrides/wivrn.nix)
    (import ./overrides/wlx-overlay-s.nix)
    (import ./overrides/xrizer.nix)
  ];
}

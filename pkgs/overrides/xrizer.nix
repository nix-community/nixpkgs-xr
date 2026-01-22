# SPDX-FileCopyrightText: 2025 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev:
let
  # Use latest rustPlatform if compatible, otherwise use 1.89
  # This ensure compatibility with stable releases
  rustPlatform =
    if final.lib.versionAtLeast final.rustPackages.rustc.version "1.88" then
      final.rustPackages.rustPlatform
    else
      final.rustPackages_1_89.rustPlatform;
in
{
  xrizer =
    (prev.xrizer.override {
      inherit rustPlatform;
    }).overrideAttrs
      (prevAttrs: {
        inherit (final.xrSources.xrizer) pname version src;

        patches = builtins.filter (
          patch: (!builtins.elem patch.name [ "xrizer-fix-aarch64.patch" ])
        ) prevAttrs.patches;

        cargoDeps = rustPlatform.importCargoLock final.xrSources.xrizer.cargoLock."Cargo.lock";
      });
}

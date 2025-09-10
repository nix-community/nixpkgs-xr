# SPDX-FileCopyrightText: 2025 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  xrizer = prev.xrizer.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.xrizer) pname version src;

    patches = builtins.filter (
      patch: (!builtins.elem patch.name [ "xrizer-fix-flaky-tests.patch" ])
    ) prevAttrs.patches;

    cargoDeps = final.rustPlatform.importCargoLock final.xrSources.xrizer.cargoLock."Cargo.lock";
  });
}

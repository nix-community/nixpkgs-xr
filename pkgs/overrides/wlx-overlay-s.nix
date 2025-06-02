# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  wlx-overlay-s = prev.wlx-overlay-s.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.wlx-overlay-s) pname version src;

    cargoDeps = final.rustPlatform.importCargoLock final.xrSources.wlx-overlay-s.cargoLock."Cargo.lock";

    buildInputs =
      prevAttrs.buildInputs or [ ]
      ++ (with final; [
        libGL
        wayland
      ]);
  });
}

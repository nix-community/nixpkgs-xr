# SPDX-FileCopyrightText: 2025 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  xrizer = prev.xrizer.overrideAttrs {
    inherit (final.xrSources.xrizer) pname version src;

    cargoDeps = final.rustPlatform.importCargoLock final.xrSources.xrizer.cargoLock."Cargo.lock";
  };
}

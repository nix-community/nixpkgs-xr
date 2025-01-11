# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  envision-unwrapped = prev.envision-unwrapped.overrideAttrs {
    inherit (final.xrSources.envision-unwrapped) pname version src;

    cargoDeps =
      final.rustPlatform.importCargoLock
        final.xrSources.envision-unwrapped.cargoLock."Cargo.lock";

    patches = [ ];
  };
}

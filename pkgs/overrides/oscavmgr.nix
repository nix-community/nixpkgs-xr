# SPDX-FileCopyrightText: 2025 Red_M <nixpkgs-xr@red-m.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  oscavmgr = prev.oscavmgr.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.oscavmgr)
      pname
      version
      src
      date
      ;

    cargoDeps = final.rustPlatform.importCargoLock final.xrSources.oscavmgr.cargoLock."Cargo.lock";

    dontVersionCheck = true;

  });
}

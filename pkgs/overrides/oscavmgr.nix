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

    buildNoDefaultFeatures = true;
    buildFeatures = [
      "openxr"
      "babble"
    ]; # ALVR has a nasty bug (which doesn't swear, but its pretty aggressive), nixpkgs won't pull submodules down in cargo deps....

    buildInputs =
      prevAttrs.buildInputs or [ ]
      ++ (with final; [
        openxr-loader
        openssl
      ]);
    dontVersionCheck = true;
    meta = with final.lib; {
      platforms = platforms.linux;
    };
  });
}

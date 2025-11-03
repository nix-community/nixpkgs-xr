# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  oscavmgr = prev.oscavmgr.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.oscavmgr) pname version src;

    cargoDeps = final.rustPlatform.importCargoLock final.xrSources.oscavmgr.cargoLock."Cargo.lock";

    doInstallCheck = false; # sha1 doesn't match version of tool
  });
}

# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  oscavmgr = prev.oscavmgr.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.oscavmgr) pname version src;

    postPatch = ''
      alvr_session=$(echo $cargoDepsCopy/alvr_session-*/)
      substituteInPlace "$alvr_session/build.rs" \
        --replace-fail \
          'alvr_filesystem::workspace_dir().join("openvr/headers/openvr_driver.h")' \
          '"${final.openvr}/include/openvr/openvr_driver.h"'
    '';

    cargoDeps = final.rustPlatform.importCargoLock final.xrSources.oscavmgr.cargoLock."Cargo.lock";

    doInstallCheck = false; # sha1 doesn't match version of tool
  });
}

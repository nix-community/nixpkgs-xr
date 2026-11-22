# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2025 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2026 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  fetchzip,
  lib,
  mkProtonBinDerivation,
  stdenvNoCC,
}:
mkProtonBinDerivation (finalAttrs: {
  pname = "proton-ge-rtsp-bin";
  version = "GE-Proton10-33-rtsp23-4";

  steamDisplayName = "GE-Proton-rtsp";

  variants."x86_64-linux" = {
    toolName = finalAttrs.version;
    src = fetchzip {
      url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
      hash = "sha256-sP+xNPbeI1jbs081QvFmj48A/yG6IC9ZPZRvGkFZnX0=";
    };
  };

  meta = {
    description = ''
      Compatibility tool for Steam Play based on Wine and additional components.

      (This is intended for use in the `programs.steam.extraCompatPackages` option only.)
    '';
    homepage = "https://github.com/SpookySkeletons/proton-ge-rtsp";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [
      Scrumplex
      RTUnreal
      coolGi
    ];
  };
})

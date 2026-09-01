# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2025 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2026 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  fetchzip,
  lib,
  proton-ge-bin,
  stdenvNoCC,
}:
proton-ge-bin.overrideAttrs (
  finalAttrs: prevAttrs: {
    pname = "proton-ge-rtsp-bin";
    version = "GE-Proton10-33-rtsp23-4";

    inherit (finalAttrs.passthru.variants.${stdenvNoCC.hostPlatform.system}) src toolName;

    steamDisplayName = "GE-Proton-rtsp";

    passthru.variants."x86_64-linux" = {
      toolName = finalAttrs.version;
      src = fetchzip {
        url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
        hash = "sha256-sP+xNPbeI1jbs081QvFmj48A/yG6IC9ZPZRvGkFZnX0=";
      };
    };

    meta = {
      inherit (prevAttrs.meta)
        description
        license
        platforms
        sourceProvenance
        ;
      homepage = "https://github.com/SpookySkeletons/proton-ge-rtsp";
      maintainers = with lib.maintainers; [
        Scrumplex
        RTUnreal
        coolGi
      ];
    };
  }
)

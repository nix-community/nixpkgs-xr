# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2025 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2026 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2026 coolGi <me@coolgi.dev>
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
    pname = "proton-rtsp-bin";
    version = "proton-rtsp-11.0-20260609-4";

    inherit (finalAttrs.passthru.variants.${stdenvNoCC.hostPlatform.system}) src toolName;

    steamDisplayName = "Proton-RTSP";

    passthru.variants."x86_64-linux" = {
      toolName = finalAttrs.version;
      src = fetchzip {
        url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
        hash = "sha256-ENLAPkz6PhqBpGibwjnWJE8NEnUnmoM81IuPQB9Ufoc=";
      };
    };

    meta = {
      # These are generic enough to be included in non-GE Proton builds
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

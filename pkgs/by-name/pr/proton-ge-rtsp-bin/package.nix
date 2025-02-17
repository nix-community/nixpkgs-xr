# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  fetchzip,
  lib,
  proton-ge-bin,
}:
(proton-ge-bin.override {
  steamDisplayName = "GE-Proton-rtsp";
}).overrideAttrs
  (
    finalAttrs: _: {
      pname = "proton-ge-rtsp-bin";
      version = "GE-Proton9-22-rtsp17-1";

      src = fetchzip {
        url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
        hash = "sha256-GeExWNW0J3Nfq5rcBGiG2BNEmBg0s6bavF68QqJfuX8=";
      };

      meta = {
        inherit (proton-ge-bin.meta)
          description
          license
          platforms
          sourceProvenance
          ;
        homepage = "https://github.com/SpookySkeletons/proton-ge-rtsp";
        maintainers = with lib.maintainers; [
          Scrumplex
        ];
      };
    }
  )

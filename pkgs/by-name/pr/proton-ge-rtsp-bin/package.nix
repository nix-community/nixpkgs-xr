# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  fetchzip,
  lib,
  proton-ge-bin,
  xrLib,
}:
(proton-ge-bin.override {
  steamDisplayName = "GE-Proton-rtsp";
}).overrideAttrs
  (
    finalAttrs: prevAttrs: {
      pname = "proton-ge-rtsp-bin";
      version = "GE-Proton10-33-rtsp22";

      src = fetchzip {
        url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}-3.tar.gz";
        hash = "sha256-54pECXspeGSFzKeRliVSbmSvy6KmohT+NpyNOlwIsDo=";
      };

      preFixup = ''
        substituteInPlace "$steamcompattool/compatibilitytool.vdf" \
          --replace-fail "${finalAttrs.version}-3" "GE-Proton-rtsp"
      '';

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
          RTUnreal
        ];
      };
    }
  )

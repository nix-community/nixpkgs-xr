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
      version = "GE-Proton10-33-rtsp23-1";

      src = fetchzip {
        url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
        hash = "sha256-gb/d28Lmz4r5Cetp7ct2eQtQZIAcMDxY4F3XCtLk3BY=";
      };

      preFixup = ''
        substituteInPlace "$steamcompattool/compatibilitytool.vdf" \
          --replace-fail "${finalAttrs.version}" "GE-Proton-rtsp"
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

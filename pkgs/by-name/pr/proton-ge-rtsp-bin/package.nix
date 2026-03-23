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
    finalAttrs: _: {
      pname = "proton-ge-rtsp-bin";
      version = "GE-Proton10-26-rtsp20";

      src = fetchzip {
        url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
        hash = "sha256-eAJjw575cJlj7qLsPC1LgRsVMW4O754Q6SO7IV74EyE=";
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

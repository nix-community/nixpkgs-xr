# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  fetchzip,
  lib,
  proton-ge-bin,
}:
proton-ge-bin.overrideAttrs (
  finalAttrs: _: {
    pname = "proton-ge-rtsp-bin";
    version = "GE-Proton9-20-rtsp16";

    src = fetchzip {
      url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
      hash = "sha256-iq7oiDW5+51wzqYwASOGSV922c/pg1k29MdkIXlT34k=";
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

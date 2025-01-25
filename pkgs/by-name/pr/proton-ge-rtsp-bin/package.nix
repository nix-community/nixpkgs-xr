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
    version = "GE-Proton9-22-rtsp17";

    src = fetchzip {
      url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
      hash = "sha256-1zj0y7E9JWrnPC9HllFXos33rsdAt3q+NamoxNTmHHM=";
    };

    postBuild = ''
      # prevents steam from resetting compatability settings (in addition to upstream's modifications)
      sed -i -r 's|GE-Proton-rtsp[0-9]*|GE-Proton-rtsp|' $steamcompattool/compatibilitytool.vdf
      sed -i -r 's|GE-Proton-rtsp[0-9]*|GE-Proton-rtsp|' $steamcompattool/proton
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
      ];
    };
  }
)

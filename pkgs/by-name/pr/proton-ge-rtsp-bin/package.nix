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
      version = "proton-rtsp-11.0-20260609-1";

      src = fetchzip {
        url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
        hash = "sha256-/YrUjR/Ynb0clNpXSaSlfpnqJ76ZfTYP9LR/WHHCMgk=";
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

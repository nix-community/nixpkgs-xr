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
}:
let
  steamDisplayName = "Proton-RTSP";
in
(proton-ge-bin.override {
  inherit steamDisplayName;
}).overrideAttrs
  (
    finalAttrs: _: {
      pname = "proton-rtsp-bin";
      version = "proton-rtsp-11.0-20260609-1";

      src = fetchzip {
        url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
        hash = "sha256-/YrUjR/Ynb0clNpXSaSlfpnqJ76ZfTYP9LR/WHHCMgk=";
      };

      preFixup = ''
        substituteInPlace "$steamcompattool/compatibilitytool.vdf" \
          --replace-fail "${finalAttrs.version}" "${steamDisplayName}"
      '';

      meta = {
        # These are generic enough to be included in non-GE Proton builds
        inherit (proton-ge-bin.meta)
          description
          license
          sourceProvenance
          ;

        homepage = "https://github.com/SpookySkeletons/proton-ge-rtsp";
        maintainers = with lib.maintainers; [
          Scrumplex
          RTUnreal
          coolGi
        ];
        platforms = [ "x86_64-linux" ];
      };
    }
  )

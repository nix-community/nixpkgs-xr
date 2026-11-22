# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2025 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2026 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2026 coolGi <me@coolgi.dev>
#
# SPDX-License-Identifier: MIT
{
  fetchzip,
  lib,
  mkProtonBinDerivation,
}:
mkProtonBinDerivation (finalAttrs: {
  pname = "proton-rtsp-bin";
  version = "proton-rtsp-11.0-20260609-4";

  steamDisplayName = "Proton-RTSP";

  variants."x86_64-linux" = {
    toolName = finalAttrs.version;
    src = fetchzip {
      url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
      hash = "sha256-ENLAPkz6PhqBpGibwjnWJE8NEnUnmoM81IuPQB9Ufoc=";
    };
  };

  meta = {
    description = ''
      Compatibility tool for Steam Play based on Wine and additional components.

      (This is intended for use in the `programs.steam.extraCompatPackages` option only.)
    '';
    homepage = "https://github.com/SpookySkeletons/proton-ge-rtsp";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [
      Scrumplex
      RTUnreal
      coolGi
    ];
  };
})

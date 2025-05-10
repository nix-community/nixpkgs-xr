# SPDX-FileCopyrightText: 2025 Sapphire <imsapphire0@gmail.com>
#
# SPDX-License-Identifier: MIT

final: prev: {
  wivrn = prev.wivrn.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.wivrn) pname version src;

    monado = final.applyPatches {
      inherit (final.xrSources.wivrn-monado) src;
      inherit (prevAttrs.monado) patches postPatch;
    };

    meta = prevAttrs.meta // {
      broken = !final.stdenv.buildPlatform.isx86_64;
    };
  });
}

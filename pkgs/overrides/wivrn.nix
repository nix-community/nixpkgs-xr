# SPDX-FileCopyrightText: 2025 Sapphire <imsapphire0@gmail.com>
#
# SPDX-License-Identifier: MIT

final: prev: {
  wivrn = prev.wivrn.overrideAttrs (
    finalAttrs: prevAttrs: {
      inherit (final.xrSources.wivrn) pname version src;

      monado = final.applyPatches {
        inherit (final.xrSources.wivrn-monado) src;
        inherit (prevAttrs.monado) patches postPatch;
      };

      # Remove patches against stable versions
      # We need to make sure to filter this in the future, in case we have
      # NixOS compatibility patches in nixpkgs
      patches = [ ];

      buildInputs = prevAttrs.buildInputs ++ [
        final.librsvg
        final.libpng
        final.libarchive
      ];

      meta = prevAttrs.meta // {
        broken = !final.stdenv.buildPlatform.isx86_64;
      };
    }
  );
}

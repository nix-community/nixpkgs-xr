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

      # Let's make sure our monado source revision matches what is used by WiVRn upstream
      postUnpack = ''
        ourMonadoRev="${finalAttrs.monado.src.rev}"
        theirMonadoRev=$(cat ${finalAttrs.src.name}/monado-rev)
        if [ ! "$theirMonadoRev" == "$ourMonadoRev" ]; then
          echo "Our Monado source revision doesn't match WiVRn's monado-rev." >&2
          echo "  theirs: $theirMonadoRev" >&2
          echo "    ours: $ourMonadoRev" >&2
          return 1
        fi
      '';

      meta = prevAttrs.meta // {
        broken = !final.stdenv.buildPlatform.isx86_64;
      };
    }
  );
}

# SPDX-FileCopyrightText: 2025 Sapphire <imsapphire0@gmail.com>
#
# SPDX-License-Identifier: MIT

final: prev: {
  wivrn = prev.wivrn.overrideAttrs (
    finalAttrs: prevAttrs: {
      inherit (final.xrSources.wivrn) pname version src;

      nativeBuildInputs = prevAttrs.nativeBuildInputs or [ ] ++ [
        final.hexdump
      ];

      buildInputs = prevAttrs.buildInputs or [ ] ++ [
        final.kdePackages.kirigami-addons
      ];

      monado = final.applyPatches {
        inherit (final.xrSources.wivrn-monado) src;
        inherit (prevAttrs.monado) patches postPatch;
      };

      cmakeFlags =
        (final.lib.filter (flag: !final.lib.hasInfix "GIT_DESC" flag) prevAttrs.cmakeFlags)
        ++ [
          (final.lib.cmakeFeature "GIT_DESC" "v${prevAttrs.version}-0-g${
            builtins.substring 0 8 finalAttrs.version
          }")
          (final.lib.cmakeFeature "GIT_COMMIT" finalAttrs.version)
        ];
    }
  );
}

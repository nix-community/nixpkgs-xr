# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  monado = prev.monado.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.monado) pname version src;

    patches =
      builtins.filter (patch: patch.name != "monado-cylinder-aspectRatio.patch") prevAttrs.patches or [ ]
      ++ [
        # See https://gitlab.freedesktop.org/monado/monado/-/merge_requests/2923
        (final.fetchpatch2 {
          name = "monado-fix-unstable-libsurvive.patch";
          url = "https://gitlab.freedesktop.org/monado/monado/-/commit/560ffa960d577060247e39d063f60feaca2248ba.diff?full_index=1";
          hash = "sha256-fsXPXN4A3ei3EUM2bMCHVoM0+NnEgGOP4DOsfK5OKt0=";
        })
      ];
  });
}

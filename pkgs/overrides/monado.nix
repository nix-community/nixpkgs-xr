# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  monado = prev.monado.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.monado) pname version src;

    patches = builtins.filter (p: p.name != "improve-reproducibility.patch") prevAttrs.patches;
  });
}

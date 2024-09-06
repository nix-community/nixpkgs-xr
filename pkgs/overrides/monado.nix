# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  monado = prev.monado.overrideAttrs {
    inherit (final.xrSources.monado) pname version src;
  };
}

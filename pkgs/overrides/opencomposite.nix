# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  opencomposite = prev.opencomposite.overrideAttrs {
    inherit (final.xrSources.opencomposite) pname version src;
  };
}

# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  monado = prev.monado.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.monado) pname version src;

    patches = builtins.filter (
      patch: patch.name != "2a6932d46dad9aa957205e8a47ec2baa33041076.patch"
    ) prevAttrs.patches or [ ];
  });
}

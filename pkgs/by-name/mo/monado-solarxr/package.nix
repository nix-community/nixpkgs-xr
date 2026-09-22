# SPDX-FileCopyrightText: 2026 RTUnreal <unreal@rtinf.net>
#
# SPDX-License-Identifier: MIT
{
  lib,
  monado,
  xrSources,
}:
monado.overrideAttrs (
  finalAttrs: prevAttrs: {
    inherit (xrSources.monado-solarxr)
      pname
      version
      src
      date
      ;

    patches = builtins.filter (
      patch: patch.name != "monado-cylinder-aspectRatio.patch"
    ) prevAttrs.patches or [ ];

    meta = {
      description = prevAttrs.meta.description + " (SolarXR support integration)";
      homepage = "https://gitlab.freedesktop.org/rcelyte/monado";
      inherit (prevAttrs.meta) license platforms;
      maintainers = [ lib.maintainers.RTUnreal ];
    };
  }
)

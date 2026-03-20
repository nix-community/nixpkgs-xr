# SPDX-FileCopyrightText: 2026 coolGi <me@coolgi.dev>
#
# SPDX-License-Identifier: MIT

final: prev: {
  libsurvive = prev.libsurvive.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.libsurvive) pname version src;

    buildInputs =
      prevAttrs.buildInputs
      ++ (with prev; [
        python3
      ]);

    postPatch = ''
      substituteInPlace survive.pc.in \
        libs/cnkalman/cnkalman.pc.in libs/cnmatrix/cnmatrix.pc.in \
        --replace '$'{exec_prefix}/@CMAKE_INSTALL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR@
    '';
  });
}

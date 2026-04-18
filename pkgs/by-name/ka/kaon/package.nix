# SPDX-FileCopyrightText: 2025 coolGi <me@coolgi.dev>
#
# SPDX-License-Identifier: MIT
{
  lib,
  fetchzip,
  stdenv,
  qt6,
  cmake,

  xrSources,
  xrLib,
}:
let
  ValveFileVDF_src = fetchzip {
    url = "https://github.com/TinyTinni/ValveFileVDF/archive/refs/tags/v1.1.1.tar.gz";
    hash = "sha256-s7wyHIcqMDHTSudIgy/bzZixQCL/T+ziFQxZh8w15uE=";
  };
in
stdenv.mkDerivation {
  inherit (xrSources.kaon)
    pname
    version
    src
    date
    ;

  patches = [ ./0001-Disable-update-checker-by-default.patch ];

  buildInputs = [
    qt6.qtbase
    qt6.qtquick3d
  ];

  nativeBuildInputs = [
    qt6.wrapQtAppsHook
    cmake
  ];

  cmakeFlags = [
    "-DFETCHCONTENT_SOURCE_DIR_VALVEFILEVDF=${ValveFileVDF_src}"
  ];

  meta = {
    description = "Use UEVR with Steam games via Proton";
    homepage = "https://github.com/LorenDB/kaon";
    license = [ lib.licenses.gpl3 ];

    maintainers = [ xrLib.coolGi ];
    platforms = lib.platforms.linux;
  };
}

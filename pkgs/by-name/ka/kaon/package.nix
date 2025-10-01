# SPDX-FileCopyrightText: 2025 coolGi <me@coolgi.dev>
#
# SPDX-License-Identifier: MIT
{
  lib,
  stdenv,
  qt6,
  cmake,

  xrSources,
}:
let
  ValveFileVDF_src = builtins.fetchTarball {
    url = "https://github.com/TinyTinni/ValveFileVDF/archive/refs/tags/v1.1.1.tar.gz";
    sha256 = "sha256:1qg66p68fn8c2pifqkzz490b366dvcpq6j779b9k2c1ahwf35g5k";
  };

  coolgi = {
    name = "coolGi";
    email = "me@coolgi.dev";
    matrix = "@me:coolgi.dev";
    github = "coolGi69";
    githubId = 57488297;
  };
in
stdenv.mkDerivation {
  inherit (xrSources.kaon)
    pname
    version
    src
    date
    ;

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

    maintainers = [ coolgi ];
    platforms = lib.platforms.linux;
  };
}

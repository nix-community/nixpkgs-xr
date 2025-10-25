# SPDX-FileCopyrightText: 2025 ShyAssassin <ShyAssassin@assassin.dev>
#
# SPDX-License-Identifier: MIT
{
  lib,
  stdenv,
  cmake,
  opencv,

  xrSources,
}:
stdenv.mkDerivation rec {
  inherit (xrSources.opencvsharp)
    pname
    version
    src
    date
    ;

  buildInputs = [ opencv ];
  nativeBuildInputs = [ cmake ];
  sourceRoot = "${src.name}/src";

  cmakeFlags = [ (lib.cmakeFeature "CMAKE_POLICY_VERSION_MINIMUM" "3.5") ];

  meta = with lib; {
    license = licenses.asl20;
    platforms = platforms.unix;
    description = "OpenCV wrapper for .NET";
    homepage = "https://github.com/shimat/opencvsharp";
  };
}

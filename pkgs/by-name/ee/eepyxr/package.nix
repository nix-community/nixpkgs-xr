# SPDX-FileCopyrightText: 2025 Sapphire <imsapphire0@gmail.com>
# SPDX-FileCopyrightText: 2025 Aki <Aki@ToasterUwU.com>
#
# SPDX-License-Identifier: MIT
{
  callPackage,
  fetchFromGitHub,
  lib,
  openxr-loader,
  pkg-config,
  sdl3,
  stb,
  stdenv,
  zig,

  xrSources,
}:
stdenv.mkDerivation {
  inherit (xrSources.eepyxr)
    pname
    version
    src
    date
    ;

  nativeBuildInputs = [
    zig.hook
    pkg-config
  ];
  buildInputs = [
    openxr-loader
    (sdl3.overrideAttrs {
      src = fetchFromGitHub {
        owner = "Beyley";
        repo = "SDL";
        rev = "f516f2011668f6b8c9deacdaee1287620ca6b8bc";
        hash = "sha256-RvOwh5BDnl7aHc8pNGQAaLQD1ShhwSqvxUFY4Ec+YpA=";
      };
    })
    stb
  ];
  patches = [ ./0001-Use-pkg-config-to-find-system-includes-in-translateC.patch ];

  postPatch = ''
    ln -s ${callPackage ./deps.nix { }} $ZIG_GLOBAL_CACHE_DIR/p
  '';

  dontUseZigCheck = true;
  zigBuildFlags = [ "-Doptimize=ReleaseFast" ];

  meta = with lib; {
    description = "A Linux OpenXR overlay to help you sleep in VR";
    homepage = "https://github.com/Beyley/eepyxr";
    license = licenses.mit;
    maintainers = with maintainers; [
      toasteruwu
      ImSapphire
    ];
    mainProgram = "eepyxr";
    platforms = platforms.linux;
  };
}

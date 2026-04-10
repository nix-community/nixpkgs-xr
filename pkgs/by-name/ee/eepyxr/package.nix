# SPDX-FileCopyrightText: 2025 Sapphire <imsapphire0@gmail.com>
# SPDX-FileCopyrightText: 2025 Aki <Aki@ToasterUwU.com>
# SPDX-FileCopyrightText: 2026 Sefa Eyeoglu <contact@scrumplex.net>
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
  zig_0_15,

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
    zig_0_15.hook
    pkg-config
  ];
  buildInputs = [
    openxr-loader
    (sdl3.overrideAttrs {
      version = "3.5.0-unstable-2026-04-08";
      src = fetchFromGitHub {
        owner = "libsdl-org";
        repo = "SDL";
        rev = "57f3d2ea0aada9131c109aaa0dfda41839997ebf";
        hash = "sha256-tLX3uY18hWMLzkeAMcvEc0BLZ1M4vgp4FIOmnvh1yIc=";
      };
    })
    stb
  ];
  patches = [ ./0001-Use-pkg-config-to-find-system-includes-in-translateC.patch ];

  postConfigure = ''
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

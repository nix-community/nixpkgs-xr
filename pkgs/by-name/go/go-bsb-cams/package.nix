# SPDX-FileCopyrightText: 2025 Zen Dignan <zen@dignan.dev>
#
# SPDX-License-Identifier: MIT
{
  lib,
  pkg-config,
  libusb1,
  gcc,
  go,
  buildGoModule,

  xrSources,
}:
buildGoModule (finalAttrs: rec {
  inherit (xrSources.go-bsb-cams)
    pname
    version
    src
    date
    ;

  buildInputs = [ libusb1 ];
  nativeBuildInputs = [ pkg-config ];

  ld-flags = [
    "-s"
    "-w"
  ];

  vendorHash = "sha256-U5B8QJRLSb4S1N0veMPodWfxRZuk/RkCjSd/RAzow78=";

  meta = {
    mainProgram = "go-bsb-cams";
    platforms = lib.platforms.linux;
    homepage = "https://github.com/LilliaElaine/go-bsb-cams";
    description = "Simple program to take and output the Bigscreen Beyond 2e cameras to a webserver";
    maintainers = with lib.maintainers; [ zenisbestwolf ];
  };
})

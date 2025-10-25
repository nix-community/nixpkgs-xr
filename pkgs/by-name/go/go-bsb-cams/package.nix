# SPDX-FileCopyrightText: 2025 Zen Dignan <zen@dignan.dev>
#
# SPDX-License-Identifier: MIT
{
  lib,
  pkg-config,
  libusb1,
  gcc,
  go,
  fetchFromGitHub,
  buildGoModule,
}:
buildGoModule (finalAttrs: rec {
  pname = "go-bsb-cams";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "LilliaElaine";
    repo = "go-bsb-cams";
    rev = finalAttrs.version;
    hash = "sha256-stenEti9ndQv5ItFiQKSoRbG0q1JA622H886fC5WOvQ=";
  };

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
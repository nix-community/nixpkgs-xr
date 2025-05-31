# SPDX-FileCopyrightText: 2025 Sapphire <imsapphire0@gmail.com>
#
# SPDX-License-Identifier: MIT
{
  lib,
  xrSources,
  stdenv,
  cmake,
  pkg-config,
  openxr-loader,
  libGL,
  vulkan-headers,
  vulkan-loader,
  xorg,
  nlohmann_json,
}:
stdenv.mkDerivation (finalAttrs: {
  inherit (xrSources.vapor)
    pname
    version
    src
    date
    ;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    openxr-loader
    libGL
    vulkan-headers
    vulkan-loader
    xorg.libX11
    nlohmann_json
  ];

  meta = {
    description = "Implementation of an OpenVR runtime on top of OpenXR";
    longDescription = ''
      VapoR is an implementation of an OpenVR runtime on top of OpenXR. It allows playing SteamVR/OpenVR games without using SteamVR.

      Supports OpenGL and Vulkan clients.

      Very work-in-progress. Testers welcome for: a) Quest headsets to improve game coverage/compatiblity b) other headsets to contribute device profiles and improve coverage
    '';
    homepage = "https://github.com/micheal65536/VapoR";
    license = [ lib.licenses.bsd2 ];

    maintainers = with lib.maintainers; [ ImSapphire ];
    platforms = [ "x86_64-linux" ];
  };
})

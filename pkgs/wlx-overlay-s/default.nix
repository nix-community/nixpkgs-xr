# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

{
  lib,
  system,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  alsa-lib,
  fontconfig,
  libxkbcommon,
  makeWrapper,
  openvr,
  openxr-loader,
  pipewire,
  pkg-config,
  shaderc,
  wayland,
  xorg,
  # Wether to include programs used in default config
  withDefaultPrograms ? true,
  pulseaudio,
  # nixpkgs-xr:
  cargoLock,
}:

rustPlatform.buildRustPackage {
  pname = "wlx-overlay-s";
  version = "0-unstable-2024-02-05";

  src = fetchFromGitHub {
    owner = "galister";
    repo = "wlx-overlay-s";
    rev = "481d6598903e9cbf1faf77b495499db42cf5f793";
    hash = "sha256-FKbDHCOeHMEEgpMBtpQr+SpsTWu4r1zLcQ+Pm5OYXeU=";
  };

  inherit cargoLock;

  nativeBuildInputs = [
    makeWrapper
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    alsa-lib
    fontconfig
    libxkbcommon
    openvr
    openxr-loader
    pipewire
    xorg.libX11
    xorg.libXext
    xorg.libXrandr
  ];

  env.SHADERC_LIB_DIR = "${lib.getLib shaderc}/lib";

  postPatch = lib.optionalString withDefaultPrograms ''
    substituteAllInPlace src/res/watch.yaml \
      --replace '"pactl"' '"${lib.getExe' pulseaudio "pactl"}"'

    # TODO: src/res/keyboard.yaml references 'whisper_stt'
  '';

  postInstall = ''
    wrapProgram $out/bin/wlx-overlay-s \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          # For winit
          wayland
          libxkbcommon
        ]
      }
  '';

  # Release builds are broken as of 2024-02-12
  dontStrip = true;
  buildType = "debug";

  meta = with lib; {
    description = "Wayland desktop overlay for SteamVR and OpenXR, Vulkan edition";
    homepage = "https://github.com/galister/wlx-overlay-s";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ Scrumplex ];
    platforms = platforms.linux;
    broken = stdenv.isAarch64;
    mainProgram = "wlx-overlay-s";
  };
}

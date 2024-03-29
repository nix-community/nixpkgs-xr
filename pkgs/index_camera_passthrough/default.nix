# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  lib,
  system,
  makeRustPlatform,
  pkg-config,
  udev,
  vulkan-loader,
  openvr,
  openxr-loader,
  shaderc,
  cmake,
  # nixpkgs-xr:
  fenix,
  cargoLock,
}:
let
  toolchain = fenix.packages.${system}.minimal.toolchain;
  rustPlatform = makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  };
in
rustPlatform.buildRustPackage {
  pname = "index-camera-passthrough";
  version = "0";

  postPatch = ''
    substituteInPlace Cargo.toml \
      --replace 'openxr = "0.17.1"' 'openxr = { version = "0.17.1", features = ["linked"] }'
  '';

  # src will be added by the source override
  inherit cargoLock;

  nativeBuildInputs = [
    cmake
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    udev
    vulkan-loader
    openvr
    openxr-loader
  ];

  env.SHADERC_LIB_DIR = "${lib.getLib shaderc}/lib";

  meta = with lib; {
    description = "Experimental Valve Index camera passthrough for Linux";
    homepage = "https://github.com/yshui/index_camera_passthrough";
    license = licenses.mit;
    maintainers = with maintainers; [ Scrumplex ];
    mainProgram = "index_camera_passthrough";
    platforms = platforms.linux;
  };
}

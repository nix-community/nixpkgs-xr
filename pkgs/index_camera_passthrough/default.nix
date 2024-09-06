# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{
  cmake,
  lib,
  openxr-loader,
  pkg-config,
  rustPlatform,
  shaderc,
  udev,
  vulkan-loader,
  # nixpkgs-xr:
  cargoLock,
}:
rustPlatform.buildRustPackage {
  pname = "index-camera-passthrough";
  version = "0";

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
    openxr-loader
  ];

  postPatch = ''
    substituteInPlace Cargo.toml \
      --replace-fail \
        'openxr = { version = "0.17.1", optional = true }' \
        'openxr = { version = "0.17.1", optional = true, features = ["linked"] }'
  '';

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

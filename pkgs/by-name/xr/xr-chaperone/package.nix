# SPDX-FileCopyrightText: 2026 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

{
  autoPatchelfHook,
  lib,
  libGL,
  libx11,
  libxcursor,
  libxi,
  libxkbcommon,
  openxr-loader,
  rustPlatform,
  shaderc,
  wayland,

  xrSources,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  inherit (xrSources.xr-chaperone)
    pname
    version
    src
    date
    ;
  cargoLock = xrSources.xr-chaperone.cargoLock."Cargo.lock";

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    openxr-loader
  ];

  runtimeDependencies = [
    wayland
    libxkbcommon
    libGL
    libx11
    libxcursor
    libxi
  ];

  env.SHADERC_LIB_DIR = "${lib.getLib shaderc}/lib";

  meta = {
    description = "A VR Chaperone System for OpenXR";
    homepage = "https://github.com/FrostyCoolSlug/xr-chaperone";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ Scrumplex ];
    mainProgram = "xr-chaperone";
  };
})

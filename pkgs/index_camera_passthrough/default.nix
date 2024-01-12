{
  lib,
  rustPlatform,
  pkg-config,
  udev,
  vulkan-loader,
  openvr,
  shaderc,
  cmake,
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
    openvr
  ];

  env.SHADERC_LIB_DIR = "${lib.getLib shaderc}/lib";

  meta = with lib; {
    description = "Experimental Valve Index camera passthrough for Linux";
    homepage = "https://github.com/yshui/index_camera_passthrough";
    license = licenses.mit;
    maintainers = with maintainers; [Scrumplex];
    mainProgram = "index_camera_passthrough";
    platforms = platforms.linux;
  };
}

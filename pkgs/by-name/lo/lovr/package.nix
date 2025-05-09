# SPDX-FileCopyrightText: 2025 Red_M <nixpkgs-xr@red-m.net>
#
# SPDX-License-Identifier: MIT

{
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
  pkg-config,
  git,
  luajit,
  glfw,
  glslang,
  openxr-loader,
  vulkan-loader,
  ode,
  xorg,
  python3,
  curl,
  wayland,
}:

stdenv.mkDerivation rec {
  pname = "lovr";
  version = "v0.17.1";
  src = [
    (fetchFromGitHub {
      name = pname;
      owner = "bjornbytes";
      repo = pname;
      fetchSubmodules = true;
      rev = "161856b5ed4e6db38653552f515d58b6b485bf9b"; # latest release is broken
      hash = "sha256-cO9cJH1/9hy0LmAuINXOERZ64nzwna9kPZlFGndsL+g=";
    })
    (fetchFromGitHub {
      # This gets pulled in via cmake and not as a submodule, so we need to get it and tell cmake that we already have it
      name = "JoltPhysics";
      owner = "jrouwe";
      repo = "JoltPhysics";
      fetchSubmodules = true;
      rev = "c10d9b2a8ee134fb5e72de1a0f26f8c9cc8f6382";
      hash = "sha256-owI9uM/hjicuUWXYeZOhfYby5ygWm3JOO/qifRGiOdM=";
    })
  ];
  sourceRoot = pname;

  buildInputs = [
    wayland
    luajit
    glfw
    glslang
    openxr-loader
    vulkan-loader
    ode
    xorg.libX11
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXcursor
    xorg.xinput
    xorg.libXi
    python3
    curl
    git
  ];
  nativeBuildInputs = [
    cmake
    pkg-config
    wayland
  ];
  cmakeFlags = [
    (lib.cmakeOptionType "path" "FETCHCONTENT_SOURCE_DIR_JOLTPHYSICS" "${builtins.elemAt src 1}")
    (lib.cmakeBool "GLFW_BUILD_WAYLAND" true)
    (lib.cmakeBool "LOVR_SYSTEM_GLFW" true)
    (lib.cmakeBool "LOVR_SYSTEM_LUA" true)
    (lib.cmakeBool "LOVR_SYSTEM_OPENXR" true)
    (lib.cmakeBool "LOVR_BUILD_BUNDLE" true)
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/lib
    cp -r bin/lovr $out/bin/
    cp -r bin/*.so $out/lib/
    runHook postInstall
  '';
  meta = with lib; {
    description = "A simple Lua framework for rapidly building VR experiences.";
    homepage = "https://lovr.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "lovr";
    platforms = platforms.linux;
  };
}

# SPDX-FileCopyrightText: 2025 Red_M <nixpkgs-xr@red-m.net>
#
# SPDX-License-Identifier: MIT

{
  cmake,
  curl,
  fetchFromGitHub,
  git,
  glfw,
  glslang,
  lib,
  libX11,
  libXcursor,
  libXi,
  libXinerama,
  libXrandr,
  libpulseaudio,
  libxcb,
  luajit,
  ode,
  openxr-loader,
  pkg-config,
  python3,
  stdenv,
  vulkan-loader,
  wayland,
  xinput,
  xrLib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "lovr";
  version = "0.18.0";

  src = [
    (fetchFromGitHub {
      name = "lovr";
      owner = "bjornbytes";
      repo = "lovr";
      fetchSubmodules = true;
      tag = "v${finalAttrs.version}";
      hash = "sha256-SyKJv9FmJyLGc3CT0JBNewvjtsmXKxiqaptysWiY4co=";
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
  sourceRoot = finalAttrs.pname;

  buildInputs = [
    wayland
    luajit
    glfw
    glslang
    openxr-loader
    vulkan-loader
    ode
    libX11
    libXrandr
    libXinerama
    libXcursor
    libxcb
    xinput
    libXi
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
    (lib.cmakeOptionType "path" "FETCHCONTENT_SOURCE_DIR_JOLTPHYSICS"
      "${builtins.elemAt finalAttrs.src 1}"
    )
    (lib.cmakeBool "GLFW_BUILD_WAYLAND" true)
    (lib.cmakeBool "LOVR_SYSTEM_GLFW" true)
    (lib.cmakeBool "LOVR_SYSTEM_LUA" true)
    (lib.cmakeBool "LOVR_SYSTEM_OPENXR" true)
    (lib.cmakeBool "LOVR_BUILD_BUNDLE" true)
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 -t $out/bin bin/lovr
    install -Dm755 -t $out/lib bin/*.so

    patchelf $out/bin/lovr \
      --add-needed ${vulkan-loader}/lib/libvulkan.so.1 \
      --add-needed ${libpulseaudio}/lib/libpulse.so

    runHook postInstall
  '';
  meta = {
    description = "A simple Lua framework for rapidly building VR experiences.";
    homepage = "https://lovr.org/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ xrLib.Red_M ];
    mainProgram = "lovr";
    platforms = lib.platforms.linux;
  };
})

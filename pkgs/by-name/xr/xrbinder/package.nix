# SPDX-FileCopyrightText: 2025 Red_M <nixpkgs-xr@red-m.net>
#
# SPDX-License-Identifier: MIT

{
  stdenv,
  lib,
  cmake,
  makeWrapper,
  pkg-config,
  SDL2,
  imgui,
  libX11,

  xrSources,
}:

stdenv.mkDerivation {
  inherit (xrSources.xrbinder)
    pname
    version
    src
    date
    ;

  nativeBuildInputs = [
    cmake
    makeWrapper
    pkg-config
  ];
  buildInputs = [
    (SDL2.overrideAttrs {
      dontDisableStatic = true;
    })
    imgui
    libX11
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/openxr/1
    cp -r ./XR_APILAYER_NOVENDOR_xr_binder $out/share/openxr/1/api_layers/

    runHook postInstall
  '';

  meta = {
    description = "Advanced OpenXR binding layer";
    homepage = "https://gitlab.com/mittorn/xrBinder";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.linux;
  };
}

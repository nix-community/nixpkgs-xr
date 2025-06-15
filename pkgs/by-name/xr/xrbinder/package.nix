# SPDX-FileCopyrightText: 2025 Red_M <nixpkgs-xr@red-m.net>
#
# SPDX-License-Identifier: MIT

{
  stdenv,
  lib,
  fetchFromGitLab,
  cmake,
  makeWrapper,
  pkg-config,
  SDL2,
  imgui,
  xorg,

  xrSources,
}:

stdenv.mkDerivation {
  inherit (xrSources.xrbinder)
    pname
    version
    src
    date
    ;

  buildInputs = [
    (SDL2.overrideAttrs (old: {
      dontDisableStatic = true;
    }))
    imgui
    xorg.libX11
  ];
  nativeBuildInputs = [
    cmake
    makeWrapper
    pkg-config
  ];

  installPhase = ''
    runHook preInstall
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

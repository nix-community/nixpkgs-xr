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

stdenv.mkDerivation rec {
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
  ];
  nativeBuildInputs = [
    cmake
    makeWrapper
    pkg-config
    xorg.libX11.dev
  ];

  installPhase = ''
    runHook preInstall
    cp -r ./XR_APILAYER_NOVENDOR_xr_binder $out/
    runHook postInstall
  '';
  meta = with lib; {
    description = "Advanced OpenXR binding layer";
    homepage = "https://gitlab.com/mittorn/xrBinder";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}

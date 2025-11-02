# SPDX-FileCopyrightText: 2025 Red_M <nixpkgs-xr@red-m.net>
#
# SPDX-License-Identifier: MIT

{
  lib,
  lovr,
  makeBinaryWrapper,
  stdenvNoCC,
  xrSources,
  xrLib,
}:
stdenvNoCC.mkDerivation {
  inherit (xrSources.lovr-playspace)
    pname
    src
    version
    ;

  nativeBuildInputs = [ makeBinaryWrapper ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/lovr-playspace/json
    install -Dm644 -t $out/share/lovr-playspace *.lua
    install -Dm644 -t $out/share/lovr-playspace/json json/*.lua

    makeWrapper ${lib.getExe lovr} $out/bin/lovr-playspace \
      --add-flag $out/share/lovr-playspace

    runHook postInstall
  '';

  meta = {
    description = "Uses LOVR for projecting a playspace area while using OpenXR";
    homepage = "https://github.com/SpookySkeletons/lovr-playspace";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ xrLib.Red_M ];
    mainProgram = "lovr-playspace";
    platforms = lib.platforms.linux;
  };
}

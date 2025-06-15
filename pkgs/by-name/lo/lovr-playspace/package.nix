# SPDX-FileCopyrightText: 2025 Red_M <nixpkgs-xr@red-m.net>
#
# SPDX-License-Identifier: MIT

{
  stdenv,
  lib,
  fetchFromGitHub,
  symlinkJoin,
  writeTextFile,
  bash,
  lovr,

  xrSources,
}:

symlinkJoin rec {
  inherit (xrSources.lovr-playspace)
    pname
    version
    ;
  paths = [
    lovr
    (stdenv.mkDerivation {
      inherit (xrSources.lovr-playspace)
        src
        version
        ;
      pname = "${pname}-unwrapped";

      dontUseCmakeConfigure = true;

      installPhase = ''
        runHook preInstall
        mkdir -p $out/lovr-playspace $out/lovr-playspace/json
        cp -r ./*.lua $out/lovr-playspace/
        cp -r ./json/*.lua $out/lovr-playspace/json/
        runHook postInstall
      '';
    })
    (writeTextFile {
      name = "lovr-playspace-script";
      executable = true;
      destination = "/bin/lovr-playspace";
      text = ''
        #!${bash}/bin/bash
        ${lovr}/bin/lovr ${builtins.elemAt paths 1}/lovr-playspace
      '';
    })
  ];
  meta = {
    description = "Uses LOVR for projecting a playspace area while using OpenXR";
    homepage = "https://github.com/SpookySkeletons/lovr-playspace";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "lovr-playspace";
    platforms = lib.platforms.linux;
  };
}

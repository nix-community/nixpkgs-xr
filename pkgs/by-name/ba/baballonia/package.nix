# SPDX-FileCopyrightText: 2025 ShyAssassin <ShyAssassin@assassin.dev>
#
# SPDX-License-Identifier: MIT
{
  cmake,
  opencv,
  udev,
  libjpeg,
  libGL,
  fontconfig,
  xorg,
  callPackage,
  lib,
  buildDotnetModule,
  dotnetCorePackages,

  xrSources,
}:
let
  internal = builtins.fetchurl {
    url = "http://217.154.52.44:7771/builds/trainer/1.0.0.0.zip";
    sha256 = "sha256:0cfc1r1nwcrkihmi9xn4higybyawy465qa6kpls2bjh9wbl5ys82";
  };

  dotnet = dotnetCorePackages.dotnet_8;

  baballoniaPrograms = [
    cmake
    opencv
    udev
    libjpeg
    libGL
    fontconfig
    xorg.libX11
    xorg.libSM
    xorg.libICE
    (callPackage ./opencvsharp.nix { })
  ];
in
buildDotnetModule (finalAttrs: {
  inherit (xrSources.baballonia)
    pname
    # version
    src
    date
    ;
  # NOTE: We cannot use the git revision as the version as
  #       that will cause dotnet to fail
  version = "0.0.0";

  buildInputs = baballoniaPrograms;

  dotnetSdk = dotnet.sdk;
  nugetDeps = ./deps.json;
  dotnetRuntime = dotnet.runtime;
  projectFile = "src/Baballonia.Desktop/Baballonia.Desktop.csproj";

  runtimeDeps = baballoniaPrograms;

  makeWrapperArgs = [
    "--chdir"
    "${placeholder "out"}/lib/baballonia"
  ];

  postUnpack = ''
    cp ${internal} $sourceRoot/src/Baballonia.Desktop/_internal.zip

    # For some reason submodule perms get messed up
    find $sourceRoot/src -type d -exec chmod 755 {} \;
    find $sourceRoot/src -type f -exec chmod 644 {} \;
  '';

  postFixup = ''
    mkdir -p $out/lib/baballonia/Modules
    mv $out/bin/Baballonia.Desktop $out/bin/baballonia
    mv $out/lib/baballonia/Baballonia.VFTCapture.dll $out/lib/baballonia/Modules/
    mv $out/lib/baballonia/Baballonia.VFTCapture.pdb $out/lib/baballonia/Modules/
    mv $out/lib/baballonia/Baballonia.OpenCVCapture.dll $out/lib/baballonia/Modules/
    mv $out/lib/baballonia/Baballonia.OpenCVCapture.pdb $out/lib/baballonia/Modules/
    mv $out/lib/baballonia/Baballonia.IPCameraCapture.dll $out/lib/baballonia/Modules/
    mv $out/lib/baballonia/Baballonia.IPCameraCapture.pdb $out/lib/baballonia/Modules/
    mv $out/lib/baballonia/Baballonia.SerialCameraCapture.dll $out/lib/baballonia/Modules/
    mv $out/lib/baballonia/Baballonia.SerialCameraCapture.pdb $out/lib/baballonia/Modules/
  '';

  meta = {
    mainProgram = "baballonia";
    platforms = lib.platforms.linux;
    homepage = "https://babble.diy/";
    description = "Repo for the new Babble App, free and open source eye and face tracking for social VR";
    license = {
      fullName = "Babble Software Distribution License 1.0";
      url = "https://raw.githubusercontent.com/Project-Babble/Baballonia/refs/heads/main/LICENSE";
      # While the licence is based off the Apache v2 licence, a clause 10 is added breaking this
      free = false;
      redistributable = true;
    };
    maintainers = with lib.maintainers; [
      zenisbestwolf
      shyassassin
    ];
  };
})

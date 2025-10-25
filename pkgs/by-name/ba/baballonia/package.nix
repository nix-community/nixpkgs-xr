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
  fetchFromGitHub,
}: let
    internal = builtins.fetchurl {
      url = "http://217.154.52.44:7771/builds/trainer/1.0.0.0.zip";
      sha256 = "sha256:0cfc1r1nwcrkihmi9xn4higybyawy465qa6kpls2bjh9wbl5ys82";
    };

    dotnet = dotnetCorePackages.dotnet_8;

    baballoniaPrograms = [
      cmake opencv udev
      libjpeg libGL fontconfig
      xorg.libX11 xorg.libSM xorg.libICE
      (callPackage ./opencvsharp.nix {})
    ];
in buildDotnetModule(finalAttrs: {
  version = "1.1.0.8";
  pname = "baballonia";

  buildInputs = baballoniaPrograms;
  src = fetchFromGitHub {
    owner = "Project-Babble";
    repo = "Baballonia";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-OnLCK/T7b0NsExKEv95a0lM9TccJkI/uLGIe+oz3Rtw=";
    fetchSubmodules = true;
  };

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

  meta = with lib; {
    mainProgram = "baballonia";
    platforms = platforms.linux;
    homepage = "https://github.com/Project-Babble/Baballonia";
    description = "Repo for the new Babble App, free and open source eye and face tracking for social VR";
  };
})
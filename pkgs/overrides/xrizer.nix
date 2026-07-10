# SPDX-FileCopyrightText: 2025 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev:
let
  # Use latest rustPlatform if compatible, otherwise use 1.89
  # This ensure compatibility with stable releases
  rustPlatform =
    if final.lib.versionAtLeast final.rustPackages.rustc.version "1.88" then
      final.rustPackages.rustPlatform
    else
      final.rustPackages_1_89.rustPlatform;
in
{
  xrizer =
    (prev.xrizer.override {
      inherit rustPlatform;
    }).overrideAttrs
      (prevAttrs: {
        inherit (final.xrSources.xrizer) pname version src;

        nativeBuildInputs = prevAttrs.nativeBuildInputs or [ ] ++ [
          final.autoPatchelfHook
        ];

        postPatch = ''
          substituteInPlace src/graphics_backends/gl.rs \
            --replace-fail 'libGLX.so.0' '${final.lib.getLib final.libGL}/lib/libGLX.so.0'
        '';

        postInstall = ''
          patchelf $out/lib/libxrizer.so \
            --add-needed "libopenxr_loader.so.1"
        ''
        + prevAttrs.postInstall or "";

        cargoDeps = rustPlatform.importCargoLock final.xrSources.xrizer.cargoLock."Cargo.lock";
      });
}

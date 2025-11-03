# SPDX-FileCopyrightText: 2025 Red_M <nixpkgs-xr@red-m.net>
#
# SPDX-License-Identifier: MIT

{
  alsa-lib,
  atk,
  autoPatchelfHook,
  buildNpmPackage,
  cairo,
  cargo-tauri,
  gdk-pixbuf,
  glib-networking,
  importNpmLock,
  lib,
  nodejs,
  openssl,
  pango,
  pkg-config,
  rustPlatform,
  webkitgtk_4_1,
  wrapGAppsHook4,
  xrSources,
  xrLib,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  inherit (xrSources.resolute)
    pname
    version
    src
    date
    ;

  cargoLock = xrSources.resolute.cargoLock."Cargo.lock";

  frontend = buildNpmPackage {
    inherit (finalAttrs)
      src
      version
      ;
    pname = "Resolute-ui";

    npmDeps = importNpmLock {
      package = builtins.fromJSON xrSources.resolute."package.json";
      packageLock = builtins.fromJSON xrSources.resolute."package-lock.json";
    };

    npmConfigHook = importNpmLock.npmConfigHook;

    nativeBuildInputs = [
      autoPatchelfHook
    ];

    dontAutoPatchelf = true;

    preBuild = ''
      autoPatchelf node_modules/sass-embedded-linux-x64/dart-sass/src/dart
    '';

    postBuild = ''
      cp -r ./ui/dist/ $out
    '';
  };

  nativeBuildInputs = [
    cargo-tauri.hook
    nodejs
    wrapGAppsHook4
    pkg-config
  ];

  buildInputs = [
    openssl
    alsa-lib

    gdk-pixbuf
    atk
    cairo
    pango
    glib-networking
    webkitgtk_4_1
  ];

  postPatch = ''
    substituteInPlace crates/tauri-app/tauri.conf.json \
      --replace-warn '"frontendDist": "../../ui/dist"' '"frontendDist": "${finalAttrs.frontend}"'
    substituteInPlace crates/tauri-app/tauri.conf.json \
      --replace-warn '"npm run build"' '""'
  '';

  meta = {
    description = "Resolute is a friendly GUI application for installing, updating, and managing Resonite mods. The goal is to provide a cross-platform beginning-to-end setup experience for Resonite modding.";
    homepage = "https://github.com/Gawdl3y/Resolute";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ xrLib.Red_M ];
    mainProgram = "resolute-app";
    platforms = lib.platforms.linux;
  };
})

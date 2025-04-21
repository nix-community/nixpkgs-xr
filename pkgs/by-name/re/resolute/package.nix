# SPDX-FileCopyrightText: 2025 Red_M <nixpkgs-xr@red-m.net>
#
# SPDX-License-Identifier: MIT

{
  stdenv,
  lib,
  fetchFromGitHub,
  fetchNpmDeps,
  rustPlatform,
  buildNpmPackage,
  npmHooks,
  wrapGAppsHook4,
  autoPatchelfHook,
  nodejs,
  rustc,
  cargo,
  cargo-tauri,
  pkg-config,
  openssl,
  alsa-lib,
  gdk-pixbuf,
  atk,
  cairo,
  pango,
  glib-networking,
  webkitgtk_4_1,

  xrSources,
}:

rustPlatform.buildRustPackage rec {
  inherit (xrSources.resolute)
    pname
    version
    src
    date
    ;
  cargoLock = xrSources.resolute.cargoLock."Cargo.lock";

  useFetchCargoVendor = true;

  frontend = buildNpmPackage {
    inherit version src;
    pname = "Resolute-ui";

    npmDepsHash = "sha256-X+mTF7Fc4FL/Nyt8ejvsWLwmNWIDXyYKCg00mdyEWhA=";

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

  postPatch = ''
    substituteInPlace crates/tauri-app/tauri.conf.json \
    --replace-warn '"frontendDist": "../../ui/dist"' '"frontendDist": "${frontend}"'
    substituteInPlace crates/tauri-app/tauri.conf.json \
    --replace-warn '"npm run build"' '""'
  '';

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
  meta = with lib; {
    description = "Resolute is a friendly GUI application for installing, updating, and managing Resonite mods. The goal is to provide a cross-platform beginning-to-end setup experience for Resonite modding.";
    homepage = "https://github.com/Gawdl3y/Resolute";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ];
    mainProgram = "resolute-app";
    platforms = platforms.linux;
  };
}

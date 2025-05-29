# SPDX-FileCopyrightText: 2025 Hana Kretzer <hanakretzer@gmail.com>
#
# SPDX-License-Identifier: MIT
{
  lib,
  rustPlatform,
  importNpmLock,
  pkg-config,
  cargo-tauri,
  nodejs,
  glib,
  gdk-pixbuf,
  webkitgtk_4_1,
  alsa-lib,
  wrapGAppsHook4,
  librsvg,
  openssl,
  pulseaudio,

  xrSources,
}:

let
  cargoRoot = "src-tauri";

  nanoyaki = {
    name = "Hana Kretzer";
    email = "hanakretzer@gmail.com";
    github = "nanoyaki";
    githubId = 144328493;
    keys = [
      {
        fingerprint = "D89F 440C 6CD7 4753 090F  EC7A 4682 C5CB 4D9D EA3C";
      }
    ];
  };
in

rustPlatform.buildRustPackage {
  inherit (xrSources.wayvr-dashboard)
    pname
    version
    src
    date
    ;
  cargoLock = xrSources.wayvr-dashboard.cargoLock."${cargoRoot}/Cargo.lock";

  npmDeps = importNpmLock {
    npmRoot = xrSources.wayvr-dashboard.src;
  };

  nativeBuildInputs = [
    pkg-config

    cargo-tauri.hook

    nodejs
    importNpmLock.npmConfigHook

    wrapGAppsHook4
  ];

  buildInputs = [
    webkitgtk_4_1
    glib
    gdk-pixbuf
    librsvg

    openssl
    alsa-lib
  ];

  preBuild = ''
    # using sass-embedded fails at executing node_modules/sass-embedded-linux-x64/dart-sass/src/dart
    rm -r node_modules/sass-embedded*
  '';

  postInstall = ''
    gappsWrapperArgs+=(
      --prefix PATH : "${lib.makeBinPath [ pulseaudio ]}}"
    )
    install -Dm644 wayvr-dashboard.svg $out/share/icons/hicolor/scalable/apps/wayvr-dashboard.svg
  '';

  inherit cargoRoot;
  buildAndTestSubdir = cargoRoot;

  meta = {
    description = "A work-in-progress overlay application for launching various applications and games directly into a VR desktop environment";
    homepage = "https://github.com/olekolek1000/wayvr-dashboard";
    license = lib.licenses.mit;
    maintainers = [ nanoyaki ];
    platforms = lib.platforms.linux;
    mainProgram = "wayvr-dashboard";
  };
}

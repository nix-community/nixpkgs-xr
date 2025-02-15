# SPDX-FileCopyrightText: 2025 Hana Kretzer <hanakretzer@gmail.com>
#
# SPDX-License-Identifier: MIT
{
  lib,
  rustPlatform,
  fetchFromGitHub,
  importNpmLock,
  pkg-config,
  cargo-tauri,
  nodejs,
  glib,
  gtk3,
  gtk4,
  webkitgtk_4_1,
  libsoup_3,
  alsa-lib,

  xrSources,
}:

let
  pname = "wayvr-dashboard";
  version = "9246f42ddb00301fbc46d3c2999736894b2ae615";

  src = fetchFromGitHub {
    owner = "olekolek1000";
    repo = pname;
    rev = version;
    hash = "sha256-EPpa6uJcim0DfgucxXEEQjqVyFDQUeoKZMsz7X6as0g=";
  };

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
  cargoLock = xrSources.wayvr-dashboard.cargoLock."src-tauri/Cargo.lock";

  # useFetchCargoVendor = true;
  # cargoHash = "sha256-+rSyIf0GOuMKEbPrQJO+RufmTyMrSX49EvCKjOHemYA=";

  npmDeps = importNpmLock {
    npmRoot = xrSources.wayvr-dashboard.src;
  };

  nativeBuildInputs = [
    pkg-config

    cargo-tauri.hook

    nodejs
    importNpmLock.npmConfigHook
  ];

  buildInputs = [
    glib
    gtk3
    gtk4
    webkitgtk_4_1
    libsoup_3
    alsa-lib
  ];

  preBuild = ''
    # using sass-embedded fails at executing node_modules/sass-embedded-linux-x64/dart-sass/src/dart
    rm -r node_modules/sass-embedded*
  '';

  inherit cargoRoot;
  buildAndTestSubdir = cargoRoot;

  meta = {
    description = "A work-in-progress overlay application for launching various applications and games directly into a VR desktop environment";
    homepage = "https://github.com/olekolek1000/wayvr-dashboard";
    license = lib.licenses.mit;
    maintainers = [ nanoyaki ];
    platforms = lib.platforms.linux;
    mainProgram = "wayvr_dashboard";
  };
}

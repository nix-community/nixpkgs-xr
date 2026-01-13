# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  wayvr = prev.wayvr.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.wayvr) pname version src;

    cargoDeps = final.rustPlatform.importCargoLock final.xrSources.wayvr.cargoLock."Cargo.lock";

    postInstall = ''
      install -Dm644 wayvr/wayvr.desktop $out/share/applications/wayvr.desktop
      install -Dm644 wayvr/wayvr.svg $out/share/icons/hicolor/scalable/apps/wayvr.svg
    '';
  });
}

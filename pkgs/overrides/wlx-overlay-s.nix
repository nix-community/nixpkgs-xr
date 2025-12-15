# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  wlx-overlay-s = prev.wlx-overlay-s.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.wlx-overlay-s) pname version src;

    cargoDeps = final.rustPlatform.importCargoLock final.xrSources.wlx-overlay-s.cargoLock."Cargo.lock";

    buildInputs = prevAttrs.buildInputs or [ ] ++ [
      final.atk
      final.glib
      final.gtk3
      final.pango
    ];

    # wlx-overlay-s.desktop doesn't need to be patched anymore, as it already includes X-WiVRn-VR
    # watch.yaml doesn't exist anymore. pactl is now called in code: dash-frontend/src/util/pactl_wrapper.rs
    postPatch = ''
      substituteAllInPlace dash-frontend/src/util/pactl_wrapper.rs \
        --replace-fail '"pactl"' '"${final.lib.getExe' final.pulseaudio "pactl"}"'
    '';

    postInstall = ''
      install -Dm644 wlx-overlay-s/wlx-overlay-s.desktop $out/share/applications/wlx-overlay-s.desktop
      install -Dm644 wlx-overlay-s/wlx-overlay-s.svg $out/share/icons/hicolor/scalable/apps/wlx-overlay-s.svg
    '';
  });
}

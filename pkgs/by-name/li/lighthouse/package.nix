# SPDX-FileCopyrightText: 2026 Red_M <nixpkgs-xr@red-m.net>
#
# SPDX-License-Identifier: MIT

{
  stdenv,
  lib,
  fetchFromGitHub,
  rustPlatform,
  autoPatchelfHook,
  pkg-config,
  libgcc,
  dbus,

  xrSources,
  xrLib,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  inherit (xrSources.lighthouse)
    pname
    version
    src
    date
    ;
  cargoLock = xrSources.lighthouse.cargoLock."Cargo.lock";

  nativeBuildInputs = [
    autoPatchelfHook
    pkg-config
  ];
  buildInputs = [
    dbus
    libgcc
  ];

  meta = {
    description = "Control the power state of v1 and v2 lighthouses for VR devices";
    homepage = "https://github.com/ShayBox/Lighthouse";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ xrLib.Red_M ];
    mainProgram = "lighthouse";
  };
})

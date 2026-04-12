# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  wayvr = prev.wayvr.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.wayvr) pname version src;

    cargoDeps = final.rustPlatform.importCargoLock final.xrSources.wayvr.cargoLock."Cargo.lock";

    env = prevAttrs.env or { } // {
      ORT_LIB_PATH = "${final.lib.getLib final.onnxruntime}/lib";
      ORT_PREFER_DYNAMIC_LINK = 1;
    };
  });
}

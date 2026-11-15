# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  wayvr = prev.wayvr.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.wayvr) pname version src;

    cargoDeps = final.rustPlatform.importCargoLock final.xrSources.wayvr.cargoLock."Cargo.lock";

    buildInputs = prevAttrs.buildInputs or [ ] ++ [
      final.dav1d
      final.libinput
      final.systemdLibs
    ];

    postPatch =
      final.lib.replaceString "dash-frontend/src/util/pactl_wrapper.rs" "wlx-common/src/pactl_wrapper.rs"
        prevAttrs.postPatch;

    checkFlags = [
      # Upstream doesn't test this in CI so sometimes some translations are
      # missing
      "--skip=test::tests::lang_json_files_contain_all_keys"
    ];

    env = prevAttrs.env or { } // {
      ORT_LIB_PATH = "${final.lib.getLib final.onnxruntime}/lib";
      ORT_PREFER_DYNAMIC_LINK = 1;
    };
  });
}

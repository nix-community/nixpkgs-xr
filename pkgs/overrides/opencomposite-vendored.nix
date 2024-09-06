# SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

final: prev: {
  opencomposite-vendored = prev.opencomposite.overrideAttrs (prevAttrs: {
    inherit (final.xrSources.opencomposite) pname version src;

    # remove glm and openxr-loader from buildInputs
    buildInputs = final.lib.subtractLists (with final; [glm openxr-loader]) prevAttrs.buildInputs;

    cmakeFlags = prevAttrs.cmakeFlags ++ [
      (final.lib.cmakeBool "USE_SYSTEM_OPENXR" true)
      (final.lib.cmakeBool "USE_SYSTEM_GLM" true)
    ];
  });
}

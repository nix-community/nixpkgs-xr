# SPDX-FileCopyrightText: 2023 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT

{self, ...}: {
  perSystem = {pkgs, ...}: {
    packages = self.overlays.default pkgs pkgs;
  };
}

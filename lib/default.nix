# SPDX-FileCopyrightText: 2025 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
{ nixpkgs, ... }:
{
  lib = import ./lib.nix { inherit (nixpkgs) lib; };
}

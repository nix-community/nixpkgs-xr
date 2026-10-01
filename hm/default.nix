# SPDX-FileCopyrightText: 2026 Citlali del Rey <nullobsi@unix.dog>
#
# SPDX-License-Identifier: MIT

{ ... }:

{
  homeModules.nixpkgs-xr = { ... }: {
    imports = [
      ./lovr-playspace.nix
    ];
  };
}

<!--
SPDX-FileCopyrightText: 2024 Sefa Eyeoglu <contact@scrumplex.net>

SPDX-License-Identifier: CC0-1.0
-->

# nixpkgs-xr

Automated packages for XR/AR/VR tools and apps for NixOS [maintainer=@Scrumplex]

## Usage

This repository provides a [Nixpkgs overlay](https://ryantm.github.io/nixpkgs/using/overlays/)
as well as the individual packages from that overlay.
While a Flake-based setup is the preferred way of using this repository,
you can also use itw without Flakes.

### Flake-based Setup

All you have to do, to apply this overlay to your NixOS configuration,
is to add the input `github:nix-community/nixpkgs-xr` to your flake
and import the convenient NixOS module `nixpkgs-xr.nixosModules.nixpkgs-xr`.
See the example below.

> [!IMPORTANT]  
> This module adds the Nixpkgs overlay as well as [the binary cache][binary-cache] for this repository.
> If you don't want the binary cache see [manual setup](#manually-setup-flake-overlay) below.

```nix
{
  inputs = {
    # ...
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
  };

  outputs = { nixpkgs, nixpkgs-xr, ... }: {
    nixosConfigurations.foo = nixpkgs.lib.nixosSystem {
      # ...
      modules = [
        # ...
        nixpkgs-xr.nixosModules.nixpkgs-xr
      ];
    };
  };
}
```

#### Manually setup Flake overlay

In case you want to have more control over the configuration, you can also choose to configure this manually.
Assuming your NixOS configuration is right in your `flake.nix`, you can write the following module:

```nix
{
  inputs = {
    # ...
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
  };

  outputs = { nixpkgs, nixpkgs-xr, ... }: {
    nixosConfigurations.foo = nixpkgs.lib.nixosSystem {
      # ...
      modules = [
        # ...
        {
          nixpkgs.overlays = [ nixpkgs-xr.overlays.default ];

          #nix.settings = {
          #  substituters = [ "https://nix-community.cachix.org" ];
          #  trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
          #};
        }
      ];
    };
  };
}
```

### Traditional setup

Compatibility for traditional NixOS setups is provided using [flake-compat][flake-compat].
You can just add the following snippet to your configuration:

```nix
{ ... }:
let
  nixpkgs-xr = import (builtins.fetchTarball "https://github.com/nix-community/nixpkgs-xr/archive/main.tar.gz");
in
  {
    nixpkgs.overlays = [ nixpkgs-xr.overlays.default ];

    #nix.settings = {
    #  substituters = [ "https://nix-community.cachix.org" ];
    #  trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    #};
  }
```

You can also pin the tarball url using tools like [niv][niv].

[binary-cache]: https://app.cachix.org/cache/nix-community
[flake-compat]: https://github.com/edolstra/flake-compat
[niv]: https://github.com/nmattia/niv

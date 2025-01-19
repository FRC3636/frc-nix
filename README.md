# A NixOS Distribution for FRC

This repository contains Nix packages and NixOS modules for use in the FIRST Robotics Competition.

## Usage

Try it out by running a development tool

```bash
nix registry add frc-nix github:FRC3636/frc-nix

nix run frc-nix#choreo # or glass, pathplanner, datalogtool, etc.
```

or taking a look at [the example project](./example).

### Install packages in your environment

There are two main ways to install packages:

#### 1. Using the overlay (recommended)
Add to your flake.nix:
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    frc-nix.url = "github:FRC3636/frc-nix";
  };

  outputs = { self, nixpkgs, frc-nix }: {
    # For NixOS systems
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      # ...
      modules = [
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ frc-nix.overlays.default ];
          environment.systemPackages = with pkgs; [
            choreo
            glass
            pathplanner
            wpilib.shuffleboard
            # etc...
          ];
        })
      ];
    };
  };
}
```

#### 2. Using packages directly
Add to your flake.nix:
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    frc-nix.url = "github:FRC3636/frc-nix";
  };

  outputs = { self, nixpkgs, frc-nix }: {
    # For NixOS systems
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      # ...
      modules = [
        ({ pkgs, ... }: {
          environment.systemPackages = [
            frc-nix.packages.${pkgs.system}.choreo
            frc-nix.packages.${pkgs.system}.glass
            frc-nix.packages.${pkgs.system}.pathplanner
            frc-nix.packages.${pkgs.system}.shuffleboard
            # etc...
          ];
        })
      ];
    };
  };
}
```

## Binary Cache

We use [Garnix](https://garnix.io) for CI, so you can follow the directions at [Garnix's docs](https://garnix.io/docs/caching) to download pre-built versions of frc-nix's packages.

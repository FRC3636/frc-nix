# A NixOS Distribution for FRC

This repository contains Nix packages and NixOS modules for use in the FIRST Robotics Competition.

Try it out by running a development tool

```bash
nix registry add frc-nix github:FRC3636/frc-nix

nix run frc-nix#choreo # or glass, pathplanner, datalogtool, etc.
```

or taking a look at [the example project](./example).

## Binary Cache

We use [Garnix](https://garnix.io) for CI, so you can follow the directions at [Garnix's docs](https://garnix.io/docs/caching) to download pre-built versions of frc-nix's packages.

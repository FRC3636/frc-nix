{ self, ... }: # the flake inputs
{ lib, ... }: # the module arguments

{
  imports = [
    ./networking.nix
    ./services/photonvision.nix
  ];

  config = {
    nixpkgs.overlays = [ self.overlays.default ];
  };
}

{ self, ... }: # the flake inputs
{ lib, ... }: # the module arguments

{
  imports = [
    ./administration.nix
    ./networking.nix
    ./services/photonvision.nix
  ];

  config = {
    nixpkgs.overlays = [ self.overlays.default ];
  };
}

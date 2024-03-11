{
  description = "Nix packages and NixOS modules for the FIRST Robotics Competition, maintained by team 3636.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, flake-utils, nixpkgs }:
    let
      frcOverlay = final: prev: {
        photonvision = final.callPackage ./pkgs/photonvision { };
      };
    in
    {
      overlays.default = frcOverlay;
      nixosModules.default = import ./modules inputs;
    }
    //
    (flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = import nixpkgs { inherit system; overlays = [ frcOverlay ]; }; in {
          packages = {
            inherit (pkgs) photonvision;
          };

          devShell = pkgs.mkShell {
            name = "frc-nix";
            packages = with pkgs; [
              nixos-generators

              typst
            ];

            TYPST_FONT_PATHS = nixpkgs.lib.strings.concatStringsSep ":" (with pkgs; [ montserrat libre-baskerville ]);
          };
        }));
}

{
  description = "Nix packages and NixOS modules for the FIRST Robotics Competition, maintained by team 3636.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, flake-utils, nixpkgs }:
    let
      frcOverlay = final: prev: {
        photonvision = prev.callPackage ./pkgs/photonvision { };
      };
    in
    # merge all the outputs together
    nixpkgs.lib.foldl (acc: x: acc // x) { } [
      rec {
        overlays.default = frcOverlay;
        nixosModules.default = import ./modules inputs;

        nixosConfigurations = {
          minimal = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              nixosModules.default

              {
                networking = {
                  hostName = "frc-nix-minimal";

                  frc = {
                    enable = true;
                    interface = "eth0";
                    teamNumber = 3636;
                    address = 255;
                  };
                };

                users = {
                  mutableUsers = false;
                  users.root.hashedPassword = "";
                };
              }
            ];
          };
        };
      }
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

              TYPST_FONT_PATHS = nixpkgs.lib.strings.concatStringsSep ":" (with pkgs; [ montserrat cooper-hewitt libre-baskerville ]);
            };
          }))
    ];
}

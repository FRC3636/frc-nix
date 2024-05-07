{
  description = "Nix packages and NixOS modules for the FIRST Robotics Competition, maintained by team 3636.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, flake-utils, nixpkgs }:
    let
      frcOverlay = final: prev: with final; {
        advantagescope = callPackage ./pkgs/advantagescope { };
        choreo = callPackage ./pkgs/choreo { };
        elastic-dashboard = callPackage ./pkgs/elastic-dashboard { };
        pathplanner = callPackage ./pkgs/pathplanner { };
        wpilib = recurseIntoAttrs (callPackage ./pkgs/wpilib { });
      };

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "armv7l-linux"
        "armv6l-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in
    {
      overlays.default = frcOverlay;
      nixosModules.default = import ./modules inputs;
    }
    //
    (flake-utils.lib.eachSystem supportedSystems
      (system:
        let
          pkgs = import nixpkgs { inherit system; overlays = [ frcOverlay ]; };
          inherit (pkgs) lib;
        in
        {
          packages = lib.attrsets.filterAttrs
            (_: pkg: builtins.elem system pkg.meta.platforms)
            {
              inherit (pkgs)
                advantagescope
                choreo
                elastic-dashboard
                pathplanner
                photonvision;
              inherit (pkgs.wpilib)
                datalogtool
                glass
                outlineviewer
                pathweaver
                roborioteamnumbersetter
                robotbuilder
                shuffleboard
                smartdashboard
                sysid;

              frc-nix-whitepaper =
                pkgs.runCommandNoCC
                  "nixos-on-frc-robots"
                  {
                    buildInputs = with pkgs; [ typst source-serif ];
                    TYPST_FONT_PATHS = nixpkgs.lib.strings.concatStringsSep ":" (with pkgs; [ montserrat libre-baskerville ]);

                    meta.platforms = lib.platforms.all;
                  }
                  ''
                    mkdir $out
                    typst compile \
                      --root ${./whitepaper} \
                      ${./whitepaper}/nixos-on-frc-robots.typ \
                      $out/nixos-on-frc-robots.pdf
                  '';
            };

          devShell = pkgs.mkShell {
            name = "frc-nix";
            packages = with pkgs; [
              nushell
              xxd

              nixos-generators

              typst
            ];

            TYPST_FONT_PATHS = nixpkgs.lib.strings.concatStringsSep ":" (with pkgs; [ montserrat libre-baskerville ]);
          };
        }));
}

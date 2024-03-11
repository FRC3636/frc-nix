{
  description = "An example of a Nix flake for managing FRC robot coprocessors using Colmena.";

  inputs = {
    frc-nix.url = "path:..";
  };

  outputs = { self, frc-nix, nixpkgs, flake-utils, ... }:
    {
      nixosConfigurations = {
        orangepi5 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            frc-nix.nixosModules.default

            ({ modulesPath, ... }: {
              imports = [
                "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
              ];

              networking = {
                hostName = "orangepi-5";

                frc = {
                  enable = true;
                  interface = "eth0";
                  teamNumber = 3636;
                  address = 11;
                };
              };

              users = {
                mutableUsers = false;
                users.root.hashedPassword = "";
              };
            })
          ];
        };
      };
    }
    //
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          name = "frc-nix-example";

          packages = with pkgs; [
            colmena # used to deploy the configurations
            nixos-generators # swiss army knife of formats which can be generated from NixOS configurations
          ];
        };
      });
}

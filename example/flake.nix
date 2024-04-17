{
  description = "An example of a Nix flake for managing FRC robot coprocessors using Colmena.";

  inputs = {
    frc-nix.url = "path:..";
  };

  outputs = { self, frc-nix, nixpkgs, flake-utils, ... }:
    {
      nixosConfigurations = {
        mini-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            frc-nix.nixosModules.default

            ({ modulesPath, ... }: {
              services.photonvision.enable = true;

              networking = {
                hostName = "mini-pc";

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
            nixos-generators # swiss army knife of formats which can be generated from NixOS configurations
          ];
        };
      });
}

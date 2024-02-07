{ config, lib, ... }:

let
  cfg = config.networking.frc;

  mkIpAddress = teamNumber: address: "10.${toString (teamNumber / 100)}.${toString (teamNumber - teamNumber / 100 * 100)}.${toString address}";
in
{
  options = {
    networking.frc = {
      enable = lib.mkEnableOption "Enable FRC networking configuration";

      interface = lib.mkOption {
        type = lib.types.str;
        example = "eth0";
        description = "The interface on which we are connected to the robot IP address.";
      };

      teamNumber = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "The team number, used to determine the robot subnet.";
      };

      address = lib.mkOption {
        type = lib.types.int;
        description = "The number to use as the last 8 bits of the IP address.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    networking.interfaces.${cfg.interface} = {
      ipv4 = {
        # assign an address in the correct subnet
        addresses = [{ address = mkIpAddress cfg.teamNumber cfg.address; prefixLength = 24; }];
        # point the default route at the radio, or another router pretending to be the radio
        routes = [{ address = "0.0.0.0"; prefixLength = 0; via = mkIpAddress cfg.teamNumber 1; }];
      };
    };
  };
}

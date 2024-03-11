{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.services.photonvision;
in
{
  options = {
    services.photonvision = {
      enable = mkEnableOption (mdDoc "Enable PhotonVision");

      package = mkOption {
        type = types.package;
        default = pkgs.photonvision;
        defaultText = literalExpression "pkgs.photonvision";
        description = "The PhotonVision package to use.";
      };

      openFirewall = mkOption {
        description = lib.mdDoc ''
          Whether to open the required firewall ports in the firewall.
        '';
        default = true;
        type = lib.types.bool;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.photonvision = {
      description = "PhotonVision, the free, fast, and easy-to-use computer vision solution for the FIRST Robotics Competition";

      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        ExecStart = "${cfg.package}/bin/photonvision";

        # ephemeral root directory
        RuntimeDirectory = "photonvision";
        RootDirectory = "/run/photonvision";

        # setup persistent state and logs directories
        StateDirectory = "photonvision";
        LogsDirectory = "photonvision";

        BindReadOnlyPaths = [
          # mount the nix store read-only
          "/nix/store"

          # the JRE reads the user.home property from /etc/passwd
          "/etc/passwd"
        ];
        BindPaths = [
          # mount the configuration and logs directories to the host
          "/var/lib/photonvision:/photonvision_config"
          "/var/log/photonvision:/photonvision_config/logs"
        ];

        # for PhotonVision's dynamic libraries, which it writes to /tmp
        PrivateTmp = true;
      };
    };

    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [ 5800 ];
      allowedTCPPortRanges = [{ from = 1180; to = 1190; }];
    };
  };
}

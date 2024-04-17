{ config, lib, ... }:

with lib;
let
  cfg = config.services.photonvision;
in
{
  options = {
    services.photonvision = { };
  };

  config = {
    services.photonvision.openFirewall = true;
  };
}

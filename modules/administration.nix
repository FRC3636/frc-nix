{ pkgs, ... }:

{
  config = {
    environment.systemPackages = with pkgs; [
      neovim
      htop
      usbutils
      pciutils
      v4l-utils
      ethtool
    ];
  };
}

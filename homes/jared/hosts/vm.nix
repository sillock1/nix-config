{ config, pkgs, lib, ...}:
{
  imports = [
    ../../modules/desktop
  ];
  modules.desktop = {
    hyprland = {
      enable = true;
      settings = {
        # Configure your Display resolution, offset, scale and Monitors here, use `hyprctl monitors` to get the info.
        #   highres:      get the best possible resolution
        #   auto:         position automatically
        #   1.6:          scale to 1.6 times
        #   bitdepth,10:  enable 10 bit support
        monitor = "Virtual-1,highres,auto,1.6,bitdepth,10";
      };
    };
  };
}
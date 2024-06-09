{ config, pkgs, lib, ...}:
{
  imports = [
    ../../modules/desktop
  ];
  modules = {
    base = {
      development.enable = true;
    };
    desktop = {
      hyprland = {
        enable = true;
        settings = {
          # Configure your Display resolution, offset, scale and Monitors here, use `hyprctl monitors` to get the info.
          #   highres:      get the best possible resolution
          #   auto:         position automatically
          #   1.5:          scale to 1.5 times
          #   bitdepth,10:  enable 10 bit support
          monitor = "eDP-1,highres,auto,1.5,bitdepth,10";
        };
      };
      editor = {
        vscode = {
          enable = true;
          userSettings = lib.importJSON ../config/editor/vscode/settings.json;
        };
      };
    };
  };
}
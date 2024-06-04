{ config, pkgs, lib, ...}:
{
  modules = { 
    gaming = {
      enable = true;
    };
    desktops = {
      hyprland = {
        enable = true;
      };
    };
  };
}
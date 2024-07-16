{ config, pkgs, lib, ...}:
{
imports = [
    ../global
    ../features/desktop/wayland/hyprland
    ../features/games
  ];

  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      workspace = "1";
      enabled = true;
      primary = true;
    }
  ];
}
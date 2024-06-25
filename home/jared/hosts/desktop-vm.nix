{ config, pkgs, lib, ...}:
{
imports = [
    ../global
    ../features/desktop/wayland/hyprland
    ../features/games
    ../secrets
  ];

  monitors = [
    {
      name = "DP-1";
      width = 1920;
      height = 1080;
      x = 0;
      workspace = "1";
      enabled = true;
    }
  ];
}
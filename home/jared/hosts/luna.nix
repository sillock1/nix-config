{ config, pkgs, lib, ...}:
{
imports = [
    ../global
    ../features/desktop/wayland/hyprland
    ../features/development
    ../features/games
  ];

  monitors = [
    {
      name = "eDP-1";
      width = 2560;
      height = 1440;
      workspace = "1";
      enabled = true;
      primary = true;
    }
  ];
}

{ config, pkgs, lib, ...}:
{
  imports = [
    ../global
    ../features/desktop/wayland/hyprland
    ../features/development
    ../features/games
  ];

  modules = {
    desktop = {
      hyprland = {
        enable = true;
        settings = {
          monitor = [
            "HDMI-A-1,2560x1440, 0x0, 1"
            "DP-2,2560x1440, 2560x0, 1"
            "DP-1,2560x1440, 5120x0, 1"
          ];
        };
      };
    };
  };

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

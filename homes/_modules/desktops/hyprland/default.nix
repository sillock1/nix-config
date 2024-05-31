{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.desktops.hyprland;
in
{
  options.modules.desktops.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        general = {
          border_size = 2;
          gaps_in = 3;
          gaps_out = 6;
          resize_on_border = true;
          hover_icon_on_border = false;
          layout = "dwindle";
        };
        decoration = {
          rounding = 6;
          active_opacity = 1;
          inactive_opacity = 1;
          fullscreen_opacity = 1;
          drop_shadow = false;
        };
      };
    };
  };
}
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
    wayland.windowManager.hyprland.enable = true;
  };
}
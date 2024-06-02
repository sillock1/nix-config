{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.desktops.sway;
in
{
  options.modules.desktops.sway = {
    enable = lib.mkEnableOption "sway";
  };

  config = lib.mkIf cfg.enable {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty"; 
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
      ];
    };
  };
  };
}
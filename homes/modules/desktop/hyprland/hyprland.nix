{ inputs, pkgs, config, lib, ...}: 
let
  cfg = config.modules.desktop.hyprland;
in
{
  options.modules.desktop.hyprland = {
    enable = lib.mkEnableOption "hyprland";
    settings = lib.mkOption {
      type = with lib.types; let
        valueType =
          nullOr (oneOf [
            bool
            int
            float
            str
            path
            (attrsOf valueType)
            (listOf valueType)
          ])
          // {
            description = "Hyprland configuration value";
          };
      in
        valueType;
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
      settings = {
        env = [
          "NIXOS_OZONE_WL,1" # for any ozone-based browser & electron apps to run on wayland
          "MOZ_ENABLE_WAYLAND,1" # for firefox to run on wayland
          "MOZ_WEBRENDER,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_QPA_PLATFORM,wayland"
          "SDL_VIDEODRIVER,wayland"
          "GDK_BACKEND,wayland"
        ];
      };
      systemd.enable = true;
      extraConfig = builtins.readFile ./conf/hyprland.conf;
    };
    xdg.configFile = {
      "hypr/mako" = {
        source = ./conf/mako;
        recursive = true;
      };
      "hypr/scripts" = {
        source = ./conf/scripts;
        recursive = true;
        executable = true;
      };
      "hypr/waybar" = {
        source = ./conf/waybar;
        recursive = true;
      };
      "hypr/wlogout" = {
        source = ./conf/wlogout;
        recursive = true;
      };
    };
  };
}
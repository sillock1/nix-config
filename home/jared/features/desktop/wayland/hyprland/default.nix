{
  lib,
  config,
  pkgs,
  ...
}:
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
  imports = [
    ../../common
    ../common
  ];

  config = lib.mkMerge [
    ({
      xdg.portal = let
        hyprland = config.wayland.windowManager.hyprland.package;
        xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
      in {
        extraPortals = [xdph];
        configPackages = [hyprland];
      };

      home.packages = with pkgs; [
        grimblast
        hyprpicker
        xorg.xrandr
      ];
      wayland.windowManager.hyprland = {
        enable = true;
        package = pkgs.hyprland.override {wrapRuntimeDeps = false;};
        systemd = {
          enable = true;
          # Same as default, but stop graphical-session too
          extraCommands = lib.mkBefore [
            "systemctl --user stop graphical-session.target"
            "systemctl --user start hyprland-session.target"
          ];
        };
        settings = {
          env = [
            "NIXOS_OZONE_WL,1" # for any ozone-based browser & electron apps to run on wayland
            "MOZ_ENABLE_WAYLAND,1" # for firefox to run on wayland
            "MOZ_WEBRENDER,1"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            "GDK_BACKEND,wayland"
            "QT_QPA_PLATFORM,wayland;xcb"
            "SDL_VIDEODRIVER,wayland,x11"
            "CLUTTER_BACKEND,wayland"
            "XDG_CURRENT_DESKTOP,Hyprland"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"
          ];
        };
        extraConfig = builtins.readFile ../../../../config/hyprland/hyprland.conf;
        };
    })
    (lib.mkIf cfg.enable {
      wayland.windowManager.hyprland = {
        settings = cfg.settings;
      };
    })
   ];

}

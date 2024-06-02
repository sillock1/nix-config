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
  imports = [
    ../base/wofi.nix
    ../base/xdg.nix
    ../base/swaync.nix
    ../base/waybar.nix
    ../base/dconf.nix
  ];
  options.modules.desktops.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        env = [
          "NIXOS_OZONE_WL,1" # for any ozone-based browser & electron apps to run on wayland
          "MOZ_ENABLE_WAYLAND,1" # for firefox to run on wayland
          "MOZ_WEBRENDER,1"
        ];
      };
      extraConfig = builtins.readFile ../../../../files/config/hypr/hyprland.conf;
    };

    home.packages = with pkgs; [
      waybar # the status bar
      swaybg # the wallpaper
      swayidle # the idle timeout
      swaylock # locking the screen
      wlogout # logout menu
      wl-clipboard # copying and pasting
      hyprpicker # color picker

      grim # taking screenshots
      slurp # selecting a region to screenshot
      wf-recorder # screen recording

      mako # the notification daemon, the same as dunst

      yad # a fork of zenity, for creating dialogs

      # audio
      alsa-utils # provides amixer/alsamixer/...
      mpd # for playing system sounds
      mpc-cli # command-line mpd client
      ncmpcpp # a mpd client with a UI
      networkmanagerapplet # provide GUI app: nm-connection-editor
    ];
  };
}
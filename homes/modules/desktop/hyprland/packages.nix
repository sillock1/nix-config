{ inputs, pkgs, config, lib, ...}: 
let
  cfg = config.modules.desktop.hyprland;
in
{
  config = lib.mkMerge [ 
    (lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        waybar # the status bar
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
      services.hypridle.enable = true;
      programs.hyprlock.enable = true;
      programs.wpaperd.enable = true;
    })
  ];
}
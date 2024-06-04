{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.gui.hyprland;
in
{
  options.modules.gui.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
    };

    security.pam.services = {
      hyprlock = {};
      gdm.enableGnomeKeyring = true;
    };

    services.displayManager.sddm.enable = true;
    services.xserver.enable = true;

    services.blueman.enable = true;
    services.gnome.gnome-keyring.enable = true;

    # Fonts
    fonts.packages = with pkgs; [
      font-awesome
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka"  ]; })
    ];
      
    # Enable Ozone Wayland support in Chromium and Electron based applications
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Yaru";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
    environment.systemPackages = with pkgs; [
      hypridle
      hyprlock
      hyprpaper
      libnotify
      networkmanagerapplet

      brightnessctl
      grim
      pamixer
      pavucontrol
      slurp
      swappy
      tesseract
      wf-recorder
      wlr-randr
      wlsunset
    ];
  };
}
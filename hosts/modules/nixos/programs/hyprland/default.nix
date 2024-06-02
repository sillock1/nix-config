{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.programs.hyprland;
in
{
  options.modules.programs.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      portalPackage =
        pkgs.xdg-desktop-portal-wlr
        // {
          override = args: pkgs.xdg-desktop-portal-wlr.override (builtins.removeAttrs args ["hyprland"]);
        };
    };

    security.pam.services = {
      hyprlock = {};
      gdm.enableGnomeKeyring = true;
    };

    services.blueman.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;

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
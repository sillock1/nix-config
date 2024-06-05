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
  };
}
{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.gui.hyprland;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
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

    
  services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${tuigreet} --time --remember --remember-session";
          user = "greeter";
        };
      };
    };

    # this is a life saver.
    # literally no documentation about this anywhere.
    # might be good to write about this...
    # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

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
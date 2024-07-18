{
  pkgs,
  ...
}:
{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./kitty.nix
    ./waybar.nix
    ./wlogout.nix
    ./bemenu.nix
    ./wpaperd.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    wf-recorder
    wl-clipboard
    pulseaudio
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
}
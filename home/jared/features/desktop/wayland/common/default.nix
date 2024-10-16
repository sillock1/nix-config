{
  pkgs,
  ...
}:
{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./kitty.nix
    ./screenshots.nix
    ./waybar.nix
    ./wlogout.nix
    ./bemenu.nix
    ./wpaperd.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    wf-recorder
    wl-clipboard
  ];

  home.sessionVariables = {
    LIBSEAT_BACKEND = "logind";
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
}

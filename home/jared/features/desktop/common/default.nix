{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./brave.nix # Chromium browser for when DRM fucks my firefox
    ./discord.nix
    ./firefox.nix
    ./jetbrains.nix
    ./lens.nix
    ./okular.nix # PDF viewer
    ./pavucontrol.nix
    ./playerctl.nix
    ./youtube-music.nix
    ./piper.nix # Logitech controls
  ];
  xdg.portal.enable = true;
  home.packages = with pkgs; [
    pinentry-gtk2
    pinta
    unstable.teamspeak6-client
    protonvpn-gui
  ];
  services.gpg-agent.pinentry.package = lib.mkForce pkgs.pinentry-gtk2;
}

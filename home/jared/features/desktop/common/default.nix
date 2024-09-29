{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./1password.nix
    ./discord.nix
    ./firefox.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./youtube-music.nix
    ./solaar.nix
  ];
  xdg.portal.enable = true;
  home.packages = with pkgs; [
    pinentry-gtk2
  ];
  services.gpg-agent.pinentryPackage = lib.mkForce pkgs.pinentry-gtk2;
}

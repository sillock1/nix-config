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
    ./font.nix
    ./pavucontrol.nix
    ./playerctl.nix
    #./rider.nix
    ./youtube-music.nix
  ];
  xdg.portal.enable = true;
  services.gpg-agent.pinentryPackage = lib.mkForce pkgs.pinentry-gtk2;
}
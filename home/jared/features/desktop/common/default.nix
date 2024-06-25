{
  ...
}:
{
  imports = [
    ./firefox.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./font.nix
    ./discord.nix
    ./youtube-music.nix
  ];
  xdg.portal.enable = true;
}
{
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
    ./youtube-music.nix
  ];
  xdg.portal.enable = true;
}
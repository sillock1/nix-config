{
  ...
}:
{
  imports = [
    ./1password.nix
    ./firefox.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./font.nix
    ./discord.nix
    ./youtube-music.nix
  ];
  xdg.portal.enable = true;
}
{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    font-awesome
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka
  ];
}

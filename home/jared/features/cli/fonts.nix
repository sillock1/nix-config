{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    font-awesome
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka
  ];
}

{
  pkgs,
  ...
}:
{
  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka"  ]; })
  ];
}
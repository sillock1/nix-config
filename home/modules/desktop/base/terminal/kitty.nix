{
  pkgs,
  ...
}:
###########################################################
{
  programs.kitty = {
    enable = true;
    # kitty has catppuccin theme built-in,
    # all the built-in themes are packaged into an extra package named `kitty-themes`
    # and it's installed by home-manager if `theme` is specified.
    theme = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };
  };
}
{pkgs, config, ...}:
{
  programs.wlogout = {
    enable = true;
  };
  xdg.configFile."hypr/wlogout" = {
    source = ../../../../config/wlogout;
    recursive = true;
  };
}
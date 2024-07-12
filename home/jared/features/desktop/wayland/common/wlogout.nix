{pkgs, config, ...}:
{
  programs.wlogout = {
    enable = true;
  };
  xdg.configFile."hypr/wlogout" = {
    source = ../../../../config/wlogout;
    recursive = true;
  };

  # home.persistence = {
  #   "/persist/home/${config.home.username}".directories = [".config/wlogout"];
  # };
}
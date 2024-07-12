{
  pkgs,
  lib,
  config,
  ...
}: 
{
  services.hypridle = {
    enable = true;
  };
  xdg.configFile."hypr/hypridle.conf" = {
    source = ../../../../config/hypridle/hypridle.conf;
    recursive = true;
  };

  home.persistence = {
    "/persist/home/${config.home.username}".files = [".config/hypr/hypridle.conf"];
  };
}
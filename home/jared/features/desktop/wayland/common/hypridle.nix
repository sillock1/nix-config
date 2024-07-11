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
    "/persist/${config.home.homeDirectory}".files = [".config/hypr/hypridle.conf"];
  };
}
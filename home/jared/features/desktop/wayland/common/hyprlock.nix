{
  config,
  pkgs,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
  };
  xdg.configFile."hypr/hyprlock.conf" = {
    source = ../../../../config/hyprlock/hyprlock.conf;
    recursive = true;
  };

  home.persistence = {
    "/persist/${config.home.homeDirectory}".files = [".config/hypr/hyprlock.conf"];
  };
}
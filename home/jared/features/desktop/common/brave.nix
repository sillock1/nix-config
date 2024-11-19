{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    brave
  ];
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["brave.desktop"];
    "text/xml" = ["brave.desktop"];
    "x-scheme-handler/http" = ["brave.desktop"];
    "x-scheme-handler/https" = ["brave.desktop"];
  };

  home.persistence."/persist/home/${config.home.username}" = {
    directories = [".config/BraveSoftware"];
  };
}

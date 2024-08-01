{
  config,
  ...
}:
{
  programs.firefox.enable = true;
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };

  home.persistence."/persist/home/${config.home.username}" = {
    directories = [".mozilla/firefox"];
  }; 
}
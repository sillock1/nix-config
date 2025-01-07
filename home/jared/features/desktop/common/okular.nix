{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    kdePackages.okular
  ];
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = ["okular.desktop"];
  };

  home.persistence."/persist/home/${config.home.username}" = {
    directories = [
      ".config/okularrc"
      ".local/share/okular"
      ];
  };
}

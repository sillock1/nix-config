{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      lutris
      winetricks
      wineWowPackages.waylandFull
    ];
    persistence = {
      "/persist/home/${config.home.username}" = {
        allowOther = true;
        directories = [
          ".local/share/lutris"
        ];
      };
    };
  };
}
{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      lutris
      wineWowPackages.stable
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
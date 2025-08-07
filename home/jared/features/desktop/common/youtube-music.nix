{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ youtube-music ];

  home.persistence."/persist/home/${config.home.username}" = {
    directories = [ ".config/YouTube\ Music/" ];
  };
}

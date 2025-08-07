{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ discord ];

  home.persistence."/persist/home/${config.home.username}" = {
    directories = [ ".config/discord" ];
  };
}

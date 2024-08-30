{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [pavucontrol];

  home.persistence."/persist/home/${config.home.username}" = {
    files = [
      ".config/pulse/*-device-volumes.simple"
    ];
  };
}

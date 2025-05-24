{
  config,
  pkgs,
  lib,
  ...
}:
{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-cosmic
      xdg-desktop-portal-gtk
    ];
    configPackages = lib.mkDefault (
      with pkgs;
      [
        xdg-desktop-portal-cosmic
      ]
    );
  };
  home = {
    persistence = {
      "/persist/home/${config.home.username}" = {
        allowOther = true;
        directories = [
          ".config/cosmic"
        ];
      };
    };
  };
}

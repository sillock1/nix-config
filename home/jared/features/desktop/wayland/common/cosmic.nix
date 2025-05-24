{
  config,
  pkgs,
  ...
}:
{
  xdg.portal.extraPortals = with pkgs; [xdg-desktop-portal-cosmic];

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

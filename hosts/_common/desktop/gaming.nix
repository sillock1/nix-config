{
  pkgs,
  ...
}:
{
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  #hardware.xone.enable = true; # TODO: Fix when upstream is updated
  environment.systemPackages = with pkgs; [
    # Xone
    linuxKernel.packages.linux_zen.xone
    # Steam
    mangohud

    # WINE
    wine
    winetricks
    protontricks
    vulkan-tools

    # Extra dependencies
    # https://github.com/lutris/docs/
    gnutls
    openldap
    libgpg-error
    freetype
    sqlite
    libxml2
    xml2
    SDL2
  ];
}

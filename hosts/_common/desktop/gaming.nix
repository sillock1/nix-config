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

  environment.systemPackages = with pkgs; [
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
    libgpgerror
    freetype
    sqlite
    libxml2
    xml2
    SDL2
  ];
}
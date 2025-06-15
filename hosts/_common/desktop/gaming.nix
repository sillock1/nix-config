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

  services.ratbagd.enable = true; # Logitech mouse software
  hardware.xone.enable = true;
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

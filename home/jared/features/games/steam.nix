{
  pkgs,
  lib,
  config,
  ...
}: let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        gamescope
        mangohud
      ];
  };

in {
  home.packages = [
    steam-with-pkgs
    pkgs.gamescope
    pkgs.mangohud
    pkgs.protontricks
  ];
  home.persistence = {
    "/persist/home/${config.home.username}" = {
      allowOther = true;
      directories = [
        ".factorio"
        ".config/unity3d/Berserk Games/Tabletop Simulator"
        ".local/share/Tabletop Simulator"
        ".local/share/Paradox Interactive"
        ".paradoxlauncher"
        ".local/share/Steam"
      ];
    };
  };
}
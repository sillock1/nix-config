{
  outputs,
  config,
  lib,
  pkgs,
  inputs,
  ...
}: 
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
    });
  };

  xdg.configFile."waybar" = {
    source = ../../../../config/waybar;
    recursive = true;
  };

  home.persistence = {
    "/persist/${config.home.homeDirectory}".directory = [".config/waybar"];
  };
}
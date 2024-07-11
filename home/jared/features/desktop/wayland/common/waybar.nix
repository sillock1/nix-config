{
  outputs,
  config,
  lib,
  pkgs,
  inputs,
  ...
}: 
{
  systemd.user.services.waybar = {
    Unit.StartLimitBurst = 30;
  };
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
    });
    systemd.enable = true;
  };

  xdg.configFile."waybar" = {
    source = ../../../../config/waybar;
    recursive = true;
  };
}
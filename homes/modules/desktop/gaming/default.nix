{ inputs, pkgs, config, lib, ...}: 
let
  cfg = config.modules.desktop.gaming;
in
{
  options.modules.desktop.gaming = {
    enable = lib.mkEnableOption "gaming";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      prismlauncher # MC Launcher
      pcsx2 # PS2 Emulator
      gamemode
    ];
  };
}
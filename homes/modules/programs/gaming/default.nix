{
  config,
  pkgs,
  lib,
  vars,
  ...
}:
let
  cfg = config.modules.gaming;
in
{
  options.modules.gaming = {
    enable = lib.mkEnableOption "gaming";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      prismlauncher # MC Launcher
      pcsx2 # PS2 Emulator
      gamemode
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-runtime"
    ];
  };
  
}
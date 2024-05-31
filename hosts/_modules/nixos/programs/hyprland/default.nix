{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.programs.hyprland;
in
{
  options.modules.programs.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;
  };
}
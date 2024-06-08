{ inputs, pkgs, config, lib, ...}: 
let
  cfg = config.modules.desktop.editor.vscode;
in
{
  options.modules.desktop.editor.vscode = {
    enable = lib.mkEnableOption "vscode";
    userSettings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      inherit (cfg) userSettings;
    };
  };
}
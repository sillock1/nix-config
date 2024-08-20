{
  lib,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    userSettings = lib.importJSON ../../config/editor/vscode/settings.json;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      jnoortheen.nix-ide
    ];
  };
}

{
  lib,
  ...
}:
{
  programs.vscode = {
    enable = true;
    userSettings = lib.importJSON ../../config/editor/vscode/settings.json;
  };
}
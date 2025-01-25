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
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      arrterian.nix-env-selector
      redhat.vscode-yaml
    ];
  };
}

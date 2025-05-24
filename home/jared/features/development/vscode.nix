{
  lib,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = lib.importJSON ../../config/editor/vscode/settings.json;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        redhat.vscode-yaml
        ms-vscode-remote.remote-containers
      ];

    };
  };
}

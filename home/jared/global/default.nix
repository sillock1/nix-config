{
  inputs,
  lib,
  config,
  outputs,
  pkgs,
  ...
}: 
{
  imports = [inputs.impermanence.nixosModules.home-manager.impermanence]
    ++ (builtins.attrValues outputs.homeManagerModules);
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };


  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  home = {
    stateVersion = "24.05";
    username = lib.mkDefault "jared";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];

    persistence."/persist/${config.home.homeDirectory}" = {
      defaultDirectoryMethod = "symlink";
      allowOther = true;
      directories = [
        "Documents"
        "Pictures"
        "Videos"
        ".local/bin"
        ".local/share/nix" # trusted settings and repl history
        "git"
      ];
      files = [
      ];
    };
  };
}
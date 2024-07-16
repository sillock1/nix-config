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

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    stateVersion = lib.mkDefault "24.05";
    username = lib.mkDefault "jared";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    sessionPath = ["$HOME/.local/bin"];

    persistence."/persist/home/${config.home.username}" = {
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
    };
  };
}
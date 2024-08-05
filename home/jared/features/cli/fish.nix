{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  hasNeovim = config.programs.neovim.enable;
in
{
  programs.fish = {
    enable = true;
    shellAbbrs = rec {
      nr = "nixos-rebuild --flake .";
      nrs = "nixos-rebuild switch --flake .";
      snr = "sudo nixos-rebuild --flake .";
      snrs = "sudo nixos-rebuild switch --flake .";
      hm = "home-manager --flake .";
      hms = "home-manager switch --flake .";

      vim = mkIf hasNeovim "nvim";
    };
  };

  home.persistence."/persist/home/${config.home.username}" = {
    directories = [".local/share/fish/fish_history"];
  }; 
}
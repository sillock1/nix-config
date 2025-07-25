{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.jared = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "lxd"
      "minecraft"
      "network"
      "podman"
      "video"
      "wheel"
      "wireshark"
      "networkmanager"
    ];

    openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/jared/config/ssh/ssh.pub);
    hashedPasswordFile = config.sops.secrets."users/jared/password".path;
    packages = [pkgs.home-manager];
  };

  sops.secrets."users/jared/password" = {
    sopsFile = ../../secrets.sops.yaml;
    neededForUsers = true;
  };

  home-manager.users.jared = import ../../../../home/jared/hosts/${config.networking.hostName}.nix;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services = {
    hyprlock = {};
    gdm.enableGnomeKeyring = true;
  };
}

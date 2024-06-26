{ config, lib, pkgs, hostname, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../modules/desktop
    ];

  config = {

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    console.keyMap = "uk";

    networking = {
      hostName = hostname;
      firewall.enable = false;
      networkmanager.enable = true;
    };

    users.users.jared = {
      uid = 1000;
      name = "jared";
      home = "/home/jared";
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
      openssh.authorizedKeys.keys = lib.strings.splitString "\n" (builtins.readFile ../../home/jared/config/ssh/ssh.pub);
      hashedPasswordFile = config.sops.secrets."users/jared/password".path;
    };
    users.groups.jared = {
        gid = 1000;
    };

    modules = {
      gui = {
        hyprland.enable = true;
      };
    };

    hardware.opengl.enable = true;
  };
}


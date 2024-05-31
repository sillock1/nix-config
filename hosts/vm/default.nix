{ config, lib, pkgs, hostname, ... }:

{
  imports =
    [./hardware-configuration.nix];

  config = {

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

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
      openssh.authorizedKeys.keys = lib.strings.splitString "\n" (builtins.readFile ../../homes/jared/config/ssh/ssh.pub);
    };
    users.groups.jared = {
        gid = 1000;
    };

    modules = {
      services = {
        openssh = {
          enable = true;
        };
      };
      programs = {
        hyprland.enable = true;
      };
    };

    hardware = {
      opengl = {
        enable = true;
      };
    };
  };
}


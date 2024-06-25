{ config, lib, pkgs, hostname, ... }:
{
  imports =
    [
      (import ./disko-config.nix {disks = [ "/dev/vda"]; })
      
      (modulesPath + "/profiles/qemu-guest.nix")
      ./hardware-configuration.nix

      # Users for this machine
      ../common/users/jared

      ../common/global

      ../common/optional/audio.nix
      ../common/optional/1password.nix
      ../common/optional/fonts.nix
      ../common/optional/greetd.nix
      ../common/optional/swww.nix
      ../common/optional/sops.nix
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

    sops = {
      defaultSopsFile = ./secrets.sops.yaml;
      secrets = {
        "users/jared/password" = {
          neededForUsers = true;
        };
      };
    };
    
    modules = {
      gui = {
        hyprland.enable = true;
      };
      gaming = {
        enable = true;
      };
    };

    hardware.opengl.enable = true;
  };
}


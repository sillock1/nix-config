{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}:
{
  imports =
    [
      inputs.disko.nixosModules.disko
      inputs.impermanence.nixosModules.impermanence
      ./disko-config.nix

      (modulesPath + "/profiles/qemu-guest.nix")
      ./hardware-configuration.nix

      # Global config
      ../_common/global

      # Users for this machine
      ../_common/users/jared

      # Optional config
      ../_common/base/virtualisation.nix
    ];

    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      initrd = {
        availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
      };
      kernelModules = [ "kvm-amd" ];
      kernelPackages = pkgs.linuxPackages_latest;
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    console.keyMap = "uk";

    networking = {
      hostName = "sgr";
      firewall.enable = false;
      networkmanager.enable = true;
      useDHCP = lib.mkDefault true;
    };

    sops = {
      defaultSopsFile = ./secrets.sops.yaml;
      secrets = {
        "networking/bind/rndc-key" = {
          restartUnits = [ "bind.service" ];
          owner = config.users.users.named.name;
        };
        "networking/bind/externaldns-key" = {
          restartUnits = [ "bind.service" ];
          owner = config.users.users.named.name;
        };
        "networking/bind/zones/pill.ac" = {
          restartUnits = [ "bind.service" ];
          owner = config.users.users.named.name;
        };
        "networking/bind/zones/sillock.com" = {
          restartUnits = [ "bind.service" ];
          owner = config.users.users.named.name;
        };
        "networking/bind/zones/1.10.in-addr.arpa" = {
          restartUnits = [ "bind.service" ];
          owner = config.users.users.named.name;
        };
      };
    };

    modules = {
      services = {
        bind = {
          enable = true;
          config = import ./config/bind.nix {inherit config;};
        };
        dnsdist = {
          enable = true;
          config = builtins.readFile ./config/dnsdist.conf;
        };
        blocky = {
          enable = true;
          package = pkgs.unstable.blocky;
          config = import ./config/blocky.nix;
        };
        haproxy = {
          enable = true;
          config = builtins.readFile ./config/haproxy.cfg;
        };
      };
    };
  environment.persistence = lib.mkForce {};

  hardware.graphics.enable = true;
  system.stateVersion = "24.05";
}

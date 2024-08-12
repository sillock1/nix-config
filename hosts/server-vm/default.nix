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
      ./disko-config.nix
      
      (modulesPath + "/profiles/qemu-guest.nix")
      ./hardware-configuration.nix

      # Global config
      ../_common/global

      # Users for this machine
      ../_common/users/jared

      # Optional config
      ../_common/base/virtualisation.nix

      #Optional config
      ../_common/cli/fonts.nix
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
      hostName = "server-vm";
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
        "networking/bind/zones/sillock.io" = {
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
        matchbox = {
          enable = true;
          dataDir = "/var/lib/matchbox";
        };
        dnsmasq = {
          enable = true;
          hostIP = "10.1.7.128";
        };
      };
    };

  hardware.opengl.enable = true;
  system.stateVersion = "24.05";
}


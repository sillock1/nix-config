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
      
      ./hardware-configuration.nix

      # Global config
      ../_common/base

      # Users for this machine
      ../_common/users/jared

      # Optional config
      ../_common/cli/fonts.nix
      ../_common/cli/greetd.nix
      ../_common/desktop/gaming.nix
      ../_common/desktop/thunar.nix
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

    networking = {
      hostName = "luna";
      hostId = pkgs.lib.concatStringsSep "" (
        pkgs.lib.take 8 (
          pkgs.lib.stringToCharacters (builtins.hashString "sha256" config.networking.hostName)
        )
      );
      networkmanager.enable = true;
      useDHCP = lib.mkDefault true;
    };

    hardware = {
      opengl.enable = true;
      pulseaudio = {
        enable = true;
        support32Bit = true;
      };
    };

  system.stateVersion = "24.05";
}
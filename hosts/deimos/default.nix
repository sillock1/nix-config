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

      # Users for this machine
      ../common/users/jared

      ../common/global

      #Optional config
      ../common/optional/gaming.nix
      ../common/optional/swww.nix
      ../common/optional/fonts.nix
      ../common/optional/greetd.nix
      ../common/optional/thunar.nix
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
      hostName = "deimos";
      hostId = pkgs.lib.concatStringsSep "" (
        pkgs.lib.take 8 (
          pkgs.lib.stringToCharacters (builtins.hashString "sha256" config.networking.hostName)
        )
      );
      firewall.enable = false;
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

  environment.variables.NIX_REMOTE = "daemon";
  systemd.services.nix-daemon = {
    environment = {
      # Location for temporary files
      TMPDIR = "/var/cache/nix";
    };
    serviceConfig = {
      # Create /var/cache/nix automatically on Nix Daemon start
      CacheDirectory = "nix";
    };
  };

  system.stateVersion = "24.05";
}
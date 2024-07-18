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
      ../common/optional/swww.nix
      ../common/optional/fonts.nix
      ../common/optional/1password.nix
      ../common/optional/greetd.nix
    ];

    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      initrd = {
        availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
        postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/encrypted/local/root@blank && \
        echo "rollback complete"
      '';
      };
      kernelModules = [ "kvm-amd" ];
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
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

  system.stateVersion = "24.05";
}
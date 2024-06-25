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
      ./disko-config.nix
      
      (modulesPath + "/profiles/qemu-guest.nix")
      ./hardware-configuration.nix

      # Users for this machine
      ../common/users/jared

      ../common/global

      #Optional config
      ../common/optional/swww.nix
      ../common/optional/fonts.nix
      ../common/optional/1password.nix
    ];

  config = {
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

    hardware.opengl.enable = true;
  };
  system.stateVersion = "24.05";
}


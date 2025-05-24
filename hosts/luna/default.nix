{
  config,
  lib,
  pkgs,
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
      ../_common/global

      # Users for this machine
      ../_common/users/jared

      # Optional config
      ../_common/base/virtualisation.nix
      ../_common/base/impermanence.nix
      #../_common/cli/greetd.nix
      ../_common/desktop/1password.nix
      ../_common/desktop/audio.nix
      ../_common/desktop/gaming.nix
      ../_common/desktop/thunar.nix
      #../_common/desktop/gnome.nix
      #../_common/desktop/hyprland.nix
      ../_common/desktop/cosmic.nix
    ];

    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      initrd = {
        kernelModules = [ "amdgpu" ];
        availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
      };
      kernelModules = [ "kvm-amd" ];
      kernelPackages = pkgs.linuxPackages_latest;
      supportedFilesystems = [ "ntfs" ];
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

    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware = {
      cpu.amd.updateMicrocode = true;
      amdgpu.opencl.enable = true;
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages32 = with pkgs; [
          driversi686Linux.amdvlk
        ];
      };
    };

  system.stateVersion = "24.05";
}

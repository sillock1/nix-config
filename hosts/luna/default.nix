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
      ../_common/desktop/audio.nix
      ../_common/desktop/gaming.nix
      ../_common/desktop/thunar.nix
      ../_common/desktop/hyprland.nix
      ../_common/desktop/gnome.nix
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

    # amdgpu I believe gets renamed to modesetting
    services.xserver.videoDrivers = [ "modesetting" ];

    hardware = {
      opengl = {
        enable = true;
        # May need this in the next release when opengl renames to graphics
        #enable32Bit = true;
        extraPackages = with pkgs; [
          amdvlk
          vaapiVdpau
          libvdpau-va-gl
        ];
        extraPackages32 = with pkgs; [
          driversi686Linux.amdvlk
          vaapiVdpau
          libvdpau-va-gl          
        ];
      };
    };

  system.stateVersion = "24.05";
}
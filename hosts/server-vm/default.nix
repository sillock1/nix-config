{ 
  config, 
  lib, 
  pkgs,
  hostname,
  modulesPath,
  ... 
}:
{
  imports =
    [
      (modulesPath + "/profiles/qemu-guest.nix")
      ./hardware-configuration.nix
      ./secrets.nix
      (import ./disko-config.nix {disks = [ "/dev/vda"]; })
      ../modules/server
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
      hostName = hostname;
      firewall.enable = false;
      networkmanager.enable = true;
      useDHCP = lib.mkDefault true;
    };

    users.users.jared = {
      uid = 1000;
      name = "jared";
      home = "/home/jared";
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
      openssh.authorizedKeys.keys = lib.strings.splitString "\n" (builtins.readFile ../../home/jared/config/ssh/ssh.pub);
      hashedPasswordFile = config.sops.secrets."users/jared/password".path;
    };
    users.groups.jared = {
        gid = 1000;
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
      };
    };

    hardware.opengl.enable = true;
  };
}


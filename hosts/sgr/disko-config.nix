{
  ...
}:
{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            type = "EF00";
            priority = 1;
            size = "4096M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "defaults"
                "umask=0077"
              ];
            };
          };
          encryptedSwap = {
            size = "16G";
            content = {
              type = "swap";
              randomEncryption = true;
              priority = 100; # prefer to encrypt as long as we have space for it
              resumeDevice = true; # resume from hiberation from this device
            };
          };
          root = {
            size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/nix" = {
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/nix";
                  };
                  "/persist/system" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/persist/system";
                  };
                  "/persist/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/persist/home";
                  };
                };
              };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "mode=755"
          "size=1G"
        ];
      };
    };
  };
}

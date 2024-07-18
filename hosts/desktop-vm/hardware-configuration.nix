{ lib, username, ... }:
{

  fileSystems."/nix" = {
    options = [
      "compress=zstd"
      "subvol=nix"
    ];
  };

  fileSystems."/persist" = {
    neededForBoot = true;
    options = [
      "compress=zstd"
      "subvol=persist"
    ];
  };

  fileSystems."/games" = {
    device = "/dev/vdb";
    fsType = "btrfs";
    options = [
      "noatime"
    ];
  };
}
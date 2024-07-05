{ lib, username, ... }:
{
  fileSystems."/" = {
    fsType = "tmpfs";
    options = [
      "mode=755"
      "size=2G"
    ];
  };

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

  # Disable swap
  swapDevices = lib.mkForce [ ];
}
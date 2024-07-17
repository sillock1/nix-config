{ lib, username, ... }:
{
  fileSystems."/" = {
    fsType = "tmpfs";
    options = [
      "mode=755"
      "size=4G"
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
}
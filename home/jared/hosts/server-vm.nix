{ config, pkgs, lib, ...}:
{
  imports = [
    ../../modules/server
  ];
  modules = {};

  fileSystems."/home/jared/Games" = {
    depends = [ "/home" ];
    device = "/dev/vdb";
    fsType = "btrfs";
    options = [
      "compress-force=zstd"
      "noatime"
    ];
  };
}
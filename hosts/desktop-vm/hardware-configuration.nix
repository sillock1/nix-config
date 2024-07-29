{ lib, username, ... }:
{

  fileSystems."/nix".neededForBoot = true;

  fileSystems."/persist".neededForBoot = true;

  #fileSystems."/games" = {
  #  device = "/dev/vdb1";
  #};
}
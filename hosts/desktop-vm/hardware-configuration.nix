{ lib, username, ... }:
{

  fileSystems."/nix".neededForBoot = true;

  fileSystems."/persist/system" = {
    neededForBoot = true;
  };

  # fileSystems."/games" = {
  #   device = "/dev/vdb1";
  # };
}
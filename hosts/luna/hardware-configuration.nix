{
  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persist/system".neededForBoot = true;
  fileSystems."/games".device = "/dev/disk/by-id/wwn-0x500a0751e4e02e08-part1";
  fileSystems."/bigfiles".device = "/dev/disk/by-id/wwn-0x5002538d41aea481-part1";
}

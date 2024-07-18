{ lib, username, ... }:
{
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/home".neededForBoot = true;
}
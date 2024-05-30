{
  lib,
  ...
}: {
  time.timeZone = lib.mkDefault "Europe/London";
  environment .variables = {
    LANG = lib.mkDefault "en_GB.UTF-8";
    LC_ALL = lib.mkDefault "en_GB.UTF-8";
  };
}
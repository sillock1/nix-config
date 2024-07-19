{
  pkgs,
  config,
  lib,
  ...
}: 
{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    pinentryPackage =
      if config.gtk.enable
      then pkgs.pinentry-gnome3
      else pkgs.pinentry-tty;
  };
  home.packages = lib.optional config.gtk.enable pkgs.gcr;
}
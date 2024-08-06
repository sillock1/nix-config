{
  pkgs,
  ...
}: 
{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    pinentryPackage = pkgs.pinentry-tty;
    sshKeys = ["426EB695ECC57AA2B5828135EDEB772D70EA4FE9"];
  };
  home.packages = with pkgs; [
    gnupg
    yubikey-manager
  ];
}
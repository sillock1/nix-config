{...}:
{
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
    enableSshSupport = true;
    sshKeys = [ "keygrip" ];
  };


  #services.blueman.enable = true;
  #services.gnome.gnome-keyring.enable = true;
}
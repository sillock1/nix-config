{
  ...
}:
{
  imports = [
    ./locale.nix
    ./nix-ld.nix
    ./nix.nix
    ./openssh.nix
    ./packages.nix
    ./services.nix
    ./shells.nix
    ./sops.nix
    ./tty.nix
  ];

  # Fix for qt6 plugins
  environment.profileRelativeSessionVariables = {
    QT_PLUGIN_PATH = ["/lib/qt-6/plugins"];
  };

  hardware.enableRedistributableFirmware = true;
  networking.domain = "pill.ac";

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];
}

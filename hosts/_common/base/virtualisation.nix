{
  pkgs,
  ...
}:
{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd.enable = true;
  };
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
  ];

  programs.virt-manager.enable = true;
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;  # enable copy and paste between host and guest
  };
}

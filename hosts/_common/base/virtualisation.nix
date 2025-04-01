{
  pkgs,
  ...
}:
{
  virtualisation = {
    containers.enable = true;
    docker.storageDriver = "btrfs";
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    libvirtd.enable = true;
  };
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
  ];

  programs.virt-manager.enable = true;
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;  # enable copy and paste between host and guest
  };
}

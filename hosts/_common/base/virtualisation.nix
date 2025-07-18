{
  pkgs,
  ...
}:
{
  virtualisation = {
    containers.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        data-root = "/bigfiles/docker-data";
      };
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

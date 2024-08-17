{
  outputs,
  lib,
  config,
  ...
}: let
  nixosConfigs = builtins.attrNames outputs.nixosConfigurations;
  hostnames = lib.unique (nixosConfigs);
in {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      net = {
        host = builtins.concatStringsSep " " ([
            "sillock.internal"
            "*.sillock.internal"
            "*.sillock.io"
            "*.sillock.cloud"
          ]
          ++ hostnames);
        forwardAgent = true;
        
        setEnv.WAYLAND_DISPLAY = "wayland-waypipe";
        extraOptions.StreamLocalBindUnlink = "yes";
      };
    };
  };

  home.persistence = {
    "/persist/home/${config.home.username}".files = [
      #".ssh/known_hosts"
      ".ssh/id_ed25519"
    ];
  };
}
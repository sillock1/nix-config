{
  outputs,
  lib,
  config,
  ...
}: let
  nixosConfigs = builtins.attrNames outputs.nixosConfigurations;
  homeConfigs = map (n: lib.last (lib.splitString "@" n)) (builtins.attrNames outputs.homeConfigurations);
  hostnames = lib.unique (homeConfigs ++ nixosConfigs);
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
    "/persist/home/${config.home.username}".directories = [
      ".ssh"
    ];
  };
}
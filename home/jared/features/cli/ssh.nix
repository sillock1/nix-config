{
  outputs,
  lib,
  config,
  hostname,
  ...
}:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      net = {
        host = builtins.concatStringsSep " " (
          [
            "sillock.internal"
            "*.sillock.internal"
            "*.sillock.com"
            "*.sillock.cloud"
          ]
          ++ [ hostname ]
        );
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

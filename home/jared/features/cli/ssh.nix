{
  config,
  ...
}:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        forwardAgent = true;
        identityAgent = "~/.1password/agent.sock";
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

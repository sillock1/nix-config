{
  config,
  ...
}:
{
  home = {
    persistence = {
      "/persist/home/${config.home.username}" = {
        allowOther = true;
        directories = [
          ".config/openttd"
        ];
        # files = [
        #   ".config/openttd/hotkeys.cfg"
        #   ".config/openttd/hs.dat"
        #   ".config/openttd/openttd.cfg"
        #   ".config/openttd/private.cfg"
        #   ".config/openttd/secrets.cfg"
        #   ".config/openttd/windows.cfg"
        # ];
      };
    };
  };
}

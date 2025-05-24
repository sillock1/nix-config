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
          ".config/cosmic"
        ];
      };
    };
  };
}

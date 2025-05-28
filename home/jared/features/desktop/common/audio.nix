{
  config,
  ...
}:
{
  home.persistence."/persist/home/${config.home.username}" = {
    directories = [".local/state/wireplumber"];
  };
}

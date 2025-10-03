{
  config,
  ...
}:
{
  home.persistence."/persist/home/${config.home.username}" = {
    directories = [ ".config/1Password" ];
  };
}

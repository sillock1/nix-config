{
  pkgs,
  config,
  ...
}:
{
   home.packages = with pkgs; [
    _1password-cli
  ];

  home.persistence."/persist/home/${config.home.username}" = {
    directories = [".config/1Password"];
  };
}

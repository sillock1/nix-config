{
  pkgs,
  config,
  ... 
}:
{
   home.packages = with pkgs; [
    _1password
  ];

  home.persistence."/persist/home/${config.home.username}" = {
    directories = [".config/1Password"];
  }; 
}
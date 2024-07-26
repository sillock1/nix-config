{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [jetbrains.rider];

  #   home.persistence."/persist/home/${config.home.username}" = {
  #   directories = [".local/shareJetbrains/Rider"];
  # }; 
}
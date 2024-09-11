{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      unstable.jetbrains.datagrip
    ];
    persistence = {
      "/persist/home/${config.home.username}" = {
        allowOther = true;
        directories = [
          ".config/JetBrains/DataGrip*"
          "DataGripProjects"
        ];
      };
    };
  };
}

{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      unstable.jetbrains-toolbox
    ];
    persistence = {
      "/persist/home/${config.home.username}" = {
        allowOther = true;
        directories = [
          ".local/share/JetBrains"
          "RiderProjects"
          "DataGripProjects"
        ];
      };
    };
  };
}

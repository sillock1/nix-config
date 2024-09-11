{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      unstable.jetbrains.rider
    ];
    persistence = {
      "/persist/home/${config.home.username}" = {
        allowOther = true;
        directories = [
          ".config/JetBrains/Rider*"
          "RiderProjects"
        ];
      };
    };
  };
}

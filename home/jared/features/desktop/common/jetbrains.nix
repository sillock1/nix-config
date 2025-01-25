{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      unstable.jetbrains.rider
      unstable.jetbrains.datagrip
      unstable.jetbrains.idea-ultimate
      unstable.jetbrains.pycharm-professional
    ];
    persistence = {
      "/persist/home/${config.home.username}" = {
        allowOther = true;
        directories = [
          ".config/JetBrains"
          ".local/share/JetBrains"
        ];
      };
    };
  };
}

{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      jetbrains.rider
      jetbrains.datagrip
      jetbrains.idea-ultimate
      jetbrains.pycharm-professional
      jetbrains.goland
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

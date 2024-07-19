{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = [pkgs.prismlauncher];

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".local/share/PrismLauncher"];
  };
}
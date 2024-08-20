{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs.unstable; [
    r2modman
  ];

  # Enable when bug is fixed
  #home.persistence = {
  #  "/persist/home/${config.home.username}".directories = [
  #    ".config/r2modmanPlus-local"
  #  ];
  #};
}
